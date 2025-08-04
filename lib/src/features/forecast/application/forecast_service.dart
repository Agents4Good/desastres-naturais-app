import 'package:flutter/material.dart';
import 'package:aguas_da_borborema/src/features/forecast/data/mongo_repository.dart';
import 'package:aguas_da_borborema/src/features/forecast/data/local_repository.dart';
import 'package:aguas_da_borborema/src/features/forecast/domain/model_full_forecast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forecast_service.g.dart';

class ForecastService {
  ForecastService(this.ref);
  final Ref ref;

  // Future<List<PrevisaoAlagamentoCompleta>> fetchPrevisoesCompletas() async {
  //   try {
  //     return await ref.read(forecastMongoRepositoryProvider).fetchPrevisoesCompletas();
  //   } catch (e) {
  //     // Handle exceptions, log errors, etc.
  //     throw Exception('Failed to fetch flood predictions: $e');
  //   }
  // }

  Future<PrevisaoAlagamentoCompleta> fetchCurrentPrevisaoCompletaUltimosTresDias(DateTime? desiredDate) async {
    try {
      final previsoesCompletas = ref.read(forecastMongoRepositoryProvider).fetchPrevisoesCompletasUltimosTresDias();
      return previsoesCompletas.then((previsoesCompletas) {
        if (previsoesCompletas.isEmpty) {
          throw Exception('No flood predictions available');
        }
        PrevisaoAlagamentoCompleta? currentPrevisaoCompleta;
        previsoesCompletas.sort((a, b) => b.dataExecucaoPrevisao.compareTo(a.dataExecucaoPrevisao)); // Sort by date descending
        
        if (desiredDate != null) {
          currentPrevisaoCompleta = previsoesCompletas.firstWhere(
            (previsao) => DateUtils.isSameDay(previsao.dataPrevisao, desiredDate),
            orElse: () => throw Exception('No flood prediction found for the specified date'),
          );
        } else {
          currentPrevisaoCompleta = previsoesCompletas.first; // Return the most recent forecast
        }
        return currentPrevisaoCompleta;
      });
    } catch (e) {
      // Handle exceptions, log errors, etc.
      throw Exception('Failed to fetch flood predictions: $e');
    }
  }


  Future<List<PrevisaoAlagamentoCompleta>> fetchCurrentPrevisaoCompletaUltimaSemana() async {
      try {
        final previsoesCompletas = ref.read(forecastMongoRepositoryProvider).fetchPrevisoesCompletasUltimaSemana();
        return previsoesCompletas.then((previsoesCompletas) {
          if (previsoesCompletas.isEmpty) {
            throw Exception('No flood predictions available');
          }
          previsoesCompletas.sort((a, b) => b.dataExecucaoPrevisao.compareTo(a.dataExecucaoPrevisao)); // Sort by date descending
          
          return previsoesCompletas;
        });
      } catch (e) {
        // Handle exceptions, log errors, etc.
        throw Exception('Failed to fetch flood predictions: $e');
      }
    }
}

@Riverpod(keepAlive: true)
ForecastService forecastService(Ref ref) {
  return ForecastService(ref);
}
