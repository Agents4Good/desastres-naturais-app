import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aguas_da_borborema/src/features/forecast/domain/model_full_forecast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'local_repository.g.dart';

@riverpod
class ForecastLocalRepository extends _$ForecastLocalRepository {
  @override
  ForecastLocalRepository build() {
    return ForecastLocalRepository();
  }


  // Save flood predictions to local storage with shared preferences
  Future<void> setPrevisoes(String uid, PrevisaoAlagamentoCompleta previsoes) async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/previsoes.json');
    final previsoesJson = previsoes.toJson().toString();
    file.writeAsStringSync(previsoesJson);
    print('Previsões salvas em: ${file.path}');
  }
}