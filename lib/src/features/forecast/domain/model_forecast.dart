enum GravidadeAlagamento {
  baixa,
  media,
  alta,
}

class PrevisaoAlagamento {
  final double latitude;
  final double longitude;
  final GravidadeAlagamento gravidade;

  PrevisaoAlagamento({
    required this.latitude,
    required this.longitude,
    required this.gravidade,
  });

  static PrevisaoAlagamento fromJson(Map<String, dynamic> json) {
    final latitude = json['latitude'];
    if (latitude is! double) {
      throw FormatException('Invalid "latitude" value, expected type to be double in $latitude');
    }
    final longitude = json['longitude'];
    if (longitude is! double) {
      throw FormatException('Invalid "longitude" value, expected type to be double in $latitude');
    }
    final gravidade = json['gravidade'];
    if (gravidade is! String) {
      throw FormatException('Invalid "gravidade" value, expected type to be String in $latitude');
    }
    GravidadeAlagamento gravidadeObj;
    switch(gravidade.toLowerCase()) {
      case 'baixa':
        gravidadeObj = GravidadeAlagamento.baixa;
        break;
      case 'media':
        gravidadeObj = GravidadeAlagamento.media;
        break;
      case 'alta':
        gravidadeObj = GravidadeAlagamento.alta;
        break;
      default:
        throw FormatException('Invalid "gravidade" value, expected to be one of "baixa", "media", or "alta" in $latitude');
    }
    
    return PrevisaoAlagamento(
      latitude: latitude,
      longitude: longitude,
      gravidade: gravidadeObj,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'gravidade': gravidade.toString().split('.').last, // Convert enum to string
    };
  }
}
