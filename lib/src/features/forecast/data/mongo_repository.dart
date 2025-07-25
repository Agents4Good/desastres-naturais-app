import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:aguas_da_borborema/src/features/forecast/domain/model_full_forecast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mongo_repository.g.dart';

@riverpod
class ForecastMongoRepository extends _$ForecastMongoRepository {
  @override
  ForecastMongoRepository build() {
    return ForecastMongoRepository();
  }


  // Example method to fetch flood predictions
  Future<List<PrevisaoAlagamentoCompleta>> fetchPrevisoesCompletas() async {
    final String mongodbUser = dotenv.env['MONGODB_USER'] ?? 'mongo';
    final String mongodbPass = dotenv.env['MONGODB_PASS'] ?? 'pass';
    final String mongodbHost = dotenv.env['MONGODB_HOST'] ?? 'localhost';
    final String mongodbPort = dotenv.env['MONGODB_PORT'] ?? '27017';
    final String mongodbDBName = dotenv.env['MONGODB_DB_NAME'] ?? 'n8n';
    final String mongodbCollection = dotenv.env['MONGODB_PREVISOES_COLLECTION'] ?? 'previsoes';

    final String connectionString = "mongodb://$mongodbUser:$mongodbPass@$mongodbHost:$mongodbPort/n8n?authSource=admin&ssl=false";
    Db db = await Db.create(connectionString);
    await db.open();

    List<PrevisaoAlagamentoCompleta> previsoesCompletas = [];
  
    await db.collection(mongodbCollection).find(where.gt('data_execucao_previsao', DateTime.now().subtract(const Duration(days: 3)))).forEach((json) {
      previsoesCompletas.add(PrevisaoAlagamentoCompleta.fromJson(json));
    });

    return previsoesCompletas;
  }
}