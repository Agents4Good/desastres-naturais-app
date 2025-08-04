import 'dart:async';
import 'dart:collection';

import 'package:aguas_da_borborema/src/features/forecast/application/forecast_service.dart';
import 'package:aguas_da_borborema/src/features/forecast/domain/model_forecast.dart';
import 'package:aguas_da_borborema/src/features/forecast/domain/model_full_forecast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'last_week_notifications_controller.g.dart';

class PrevisaoNotificao {
  PrevisaoNotificao(
    this.dataPrevisao, [
    List<String>? _ruasGravidadeAlta,
    List<String>? _ruasGravidadeMedia,
    List<String>? _ruasGravidadeBaixa
  ]) {
  
    ruasGravidadeAlta = _ruasGravidadeAlta ?? [];
    ruasGravidadeMedia = _ruasGravidadeMedia ?? [];
    ruasGravidadeBaixa = _ruasGravidadeBaixa ?? [];
  }

  final DateTime dataPrevisao;
  late List<String> ruasGravidadeAlta;
  late List<String> ruasGravidadeMedia;
  late List<String> ruasGravidadeBaixa;
}

class PrevisaoNotificaoCompleta {
  PrevisaoNotificaoCompleta({required this.dataExecucaoPrevisao, required this.previsoes});

  final DateTime dataExecucaoPrevisao;
  final List<PrevisaoNotificao> previsoes;
}

@riverpod
class LastWeekNotificationsController extends _$LastWeekNotificationsController {

  @override
  Future<List<PrevisaoNotificaoCompleta>> build() async {
    final forecastService = ref.read(forecastServiceProvider);

    var _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
      refreshLastWeekUpdate();
    });

    ref.onDispose(() {
      _timer.cancel();
    });

    return fetchCurrentPrevisaoCompletaUltimaSemana(forecastService);
  }

  Future<List<PrevisaoNotificaoCompleta>> fetchCurrentPrevisaoCompletaUltimaSemana(ForecastService forecastService) async {
    List<PrevisaoAlagamentoCompleta> previsoesAlagamento = await forecastService.fetchCurrentPrevisaoCompletaUltimaSemana();
    
    // List<PrevisaoNotificaoCompleta> previsoesFinais;
    LinkedHashMap<DateTime, List<PrevisaoNotificao>> previsoesIntermediarias = LinkedHashMap();
    LinkedHashMap<DateTime, int> dataParaIndice = LinkedHashMap();
    
    for (var previsao in previsoesAlagamento) {
      final dataExecucaoPrevisao = previsao.dataExecucaoPrevisao;
      final dataPrevisao = previsao.dataPrevisao;
    
      if(!previsoesIntermediarias.containsKey(dataExecucaoPrevisao)) {
        previsoesIntermediarias[dataExecucaoPrevisao] = [PrevisaoNotificao(dataPrevisao)];
        dataParaIndice[dataPrevisao] = 0;
      } else if (!dataParaIndice.containsKey(dataPrevisao)) {
        dataParaIndice[dataPrevisao] = previsoesIntermediarias[dataExecucaoPrevisao]!.length - 1;
      }
    
      var indiceInteresse = dataParaIndice[dataPrevisao] ?? 0;
    
      previsoesIntermediarias[dataExecucaoPrevisao]![indiceInteresse].ruasGravidadeAlta.addAll(previsao.previsoes.where((previsao) => previsao.gravidade == GravidadeAlagamento.alta).map((previsao) => previsao.endereco));
      previsoesIntermediarias[dataExecucaoPrevisao]![indiceInteresse].ruasGravidadeMedia.addAll(previsao.previsoes.where((previsao) => previsao.gravidade == GravidadeAlagamento.media).map((previsao) => previsao.endereco));
      previsoesIntermediarias[dataExecucaoPrevisao]![indiceInteresse].ruasGravidadeBaixa.addAll(previsao.previsoes.where((previsao) => previsao.gravidade == GravidadeAlagamento.baixa).map((previsao) => previsao.endereco));
    }
    
    List<PrevisaoNotificaoCompleta> previsoesFinais = [];
    for (var entry in previsoesIntermediarias.entries) {
      var dataExecucao = entry.key;
      var previsoes = entry.value;
      previsoesFinais.add(PrevisaoNotificaoCompleta(dataExecucaoPrevisao: dataExecucao, previsoes: previsoes));
      // Process the forecasts for each execution date
    }
    
    return previsoesFinais;
  }

  /// Manually triggers a refresh of the forecast data.
  Future<void> refreshLastWeekUpdate() async {
    // 1. Set the state to loading to immediately show a progress indicator in the UI.
    state = const AsyncValue.loading();

    // 2. Re-fetch the data inside a guard. This safely handles success and error cases.
    state = await AsyncValue.guard(() {
      final forecastService = ref.read(forecastServiceProvider);
      return fetchCurrentPrevisaoCompletaUltimaSemana(forecastService);
    });
  }
}

