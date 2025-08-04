enum GravidadeAlagamento {
  baixa,
  media,
  alta,
}

class PrevisaoAlagamento {
  final double latitude;
  final double longitude;
  final GravidadeAlagamento gravidade;
  final String endereco;

  PrevisaoAlagamento({
    required this.latitude,
    required this.longitude,
    required this.gravidade,
    required this.endereco,
  });

  static PrevisaoAlagamento fromJson(Map<String, dynamic> json) {
    final latitude = json['latitude'];
    if (latitude is! double) {
      throw FormatException('Invalid "latitude" value, expected type to be double in $latitude');
    }
    final longitude = json['longitude'];
    if (longitude is! double) {
      throw FormatException('Invalid "longitude" value, expected type to be double in $longitude');
    }
    final endereco = json['endereco'];
    if (endereco is! String) {
      throw FormatException('Invalid "endereco" value, expected type to be String in $endereco');
    }
    final gravidade = json['gravidade'];
    if (gravidade is! String) {
      throw FormatException('Invalid "gravidade" value, expected type to be String in $gravidade');
    }
    GravidadeAlagamento gravidadeObj;
    switch(gravidade.toLowerCase()) {
      case 'leve':
        gravidadeObj = GravidadeAlagamento.baixa;
        break;
      case 'moderado':
        gravidadeObj = GravidadeAlagamento.media;
        break;
      case 'grave':
        gravidadeObj = GravidadeAlagamento.alta;
        break;
      default:
        throw FormatException('Invalid "gravidade" value, expected to be one of "leve", "moderada", or "grave" in $latitude');
    }
    
    return PrevisaoAlagamento(
      latitude: latitude,
      longitude: longitude,
      gravidade: gravidadeObj,
      endereco: endereco
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'gravidade': gravidade.toString().split('.').last, // Convert enum to string
      'endereco': endereco,
    };
  }
}
