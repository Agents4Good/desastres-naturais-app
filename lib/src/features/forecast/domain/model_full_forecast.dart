import 'package:aguas_da_borborema/src/features/forecast/domain/model_forecast.dart';

class PrevisaoAlagamentoCompleta {
  final List<PrevisaoAlagamento> previsoes;
  final DateTime dataExecucaoPrevisao;
  final DateTime dataPrevisao;
  final String mensagemAntes;
  final String mensagemDepois;

  PrevisaoAlagamentoCompleta({
    required this.previsoes,
    required this.dataExecucaoPrevisao,
    required this.dataPrevisao,
    required this.mensagemAntes,
    required this.mensagemDepois,
  });

  static PrevisaoAlagamentoCompleta fromJson(Map<String, dynamic> json) {
    
    final dataExecucaoPrevisao = json["data_execucao_previsao"];
    if (dataExecucaoPrevisao is! String && dataExecucaoPrevisao is! DateTime) {
      throw FormatException('Invalid date format for "date_execucao_previsao", expected type to be String or DateTime in $dataExecucaoPrevisao');
    }
    final DateTime dataExecucaoPrevisaoObj;
    if (dataExecucaoPrevisao is! DateTime) {
      dataExecucaoPrevisaoObj = DateTime.parse(dataExecucaoPrevisao as String);
    } else {
      dataExecucaoPrevisaoObj = dataExecucaoPrevisao;
    }

    final dataPrevisao = json["data_previsao"];
    if (dataPrevisao is! String && dataPrevisao is! DateTime) {
      throw FormatException('Invalid date format for "date_previsao", expected type to be String or DateTime  in $dataPrevisao');
    }
    
    final DateTime dataPrevisaoObj;
    if (dataPrevisao is! DateTime) {
      dataPrevisaoObj = DateTime.parse(dataPrevisao as String);
    } else {
      dataPrevisaoObj = dataPrevisao;
    }
    
    final previsoesJson = json['previsoes'] as List<dynamic>;
    
    final mensagemAntes = json['mensagem_antes'];
    final mensagemDepois = json['mensagem_depois'] ?? "";

    if (mensagemAntes is! String) {
      throw FormatException('Invalid "mensagem_antes" value, expected type to be String in $mensagemAntes');
    }

    if (mensagemDepois is! String) {
      throw FormatException('Invalid "mensagem_antes" value, expected type to be String in $mensagemDepois');
    }

    return PrevisaoAlagamentoCompleta(
      previsoes: previsoesJson.map((p) => PrevisaoAlagamento.fromJson(p as Map<String, dynamic>)).toList(),
      dataExecucaoPrevisao: dataExecucaoPrevisaoObj,
      dataPrevisao: dataPrevisaoObj,
      mensagemAntes: mensagemAntes,
      mensagemDepois: mensagemDepois,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'previsoes': previsoes.map((p) => p.toJson()).toList(),
      'data_execucao_previsao': dataExecucaoPrevisao.toIso8601String(),
      'data_previsao': dataPrevisao.toIso8601String(),
      'mensagem_antes': mensagemAntes,
      'mensagem_depois': mensagemDepois,
    };
  }
}
