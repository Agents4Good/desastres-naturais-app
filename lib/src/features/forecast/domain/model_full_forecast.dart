import 'package:pluvia/src/features/forecast/domain/model_forecast.dart';

class PrevisaoAlagamentoCompleta {
  final List<PrevisaoAlagamento> previsoes;
  final DateTime dataExecucaoPrevisao;
  final DateTime dataPrevisao;
  final String mensagemAntesPt;
  final String mensagemAntesEn;
  final String mensagemDepoisPt;
  final String mensagemDepoisEn;

  PrevisaoAlagamentoCompleta({
    required this.previsoes,
    required this.dataExecucaoPrevisao,
    required this.dataPrevisao,
    required this.mensagemAntesPt,
    required this.mensagemAntesEn,
    required this.mensagemDepoisPt,
    required this.mensagemDepoisEn,
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
    
    final mensagemAntesPt = json['mensagem_antes_pt'];
    final mensagemAntesEn = json['mensagem_antes_en'];
    final mensagemDepoisPt = json['mensagem_depois_pt'];
    final mensagemDepoisEn = json['mensagem_depois_en'];

    if (mensagemAntesPt is! String) {
      throw FormatException('Invalid "mensagem_antes_pt" value, expected type to be String in $mensagemAntesPt');
    }

    if (mensagemAntesEn is! String) {
      throw FormatException('Invalid "mensagem_antes_en" value, expected type to be String in $mensagemAntesEn');
    }

    if (mensagemDepoisPt is! String) {
      throw FormatException('Invalid "mensagem_depois_pt" value, expected type to be String in $mensagemDepoisPt');
    } 

    if (mensagemDepoisEn is! String) {
      throw FormatException('Invalid "mensagem_depois_en" value, expected type to be String in $mensagemDepoisEn');
    }

    return PrevisaoAlagamentoCompleta(
      previsoes: previsoesJson.map((p) => PrevisaoAlagamento.fromJson(p as Map<String, dynamic>)).toList(),
      dataExecucaoPrevisao: dataExecucaoPrevisaoObj,
      dataPrevisao: dataPrevisaoObj,
      mensagemAntesPt: mensagemAntesPt,
      mensagemAntesEn: mensagemAntesEn,
      mensagemDepoisPt: mensagemDepoisPt,
      mensagemDepoisEn: mensagemDepoisEn,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'previsoes': previsoes.map((p) => p.toJson()).toList(),
      'data_execucao_previsao': dataExecucaoPrevisao.toIso8601String(),
      'data_previsao': dataPrevisao.toIso8601String(),
      'mensagem_antes_pt': mensagemAntesPt,
      'mensagem_antes_en': mensagemAntesEn,
      'mensagem_depois_pt': mensagemDepoisPt,
      'mensagem_depois_en': mensagemDepoisEn,
    };
  }
}
