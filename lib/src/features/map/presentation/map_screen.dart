import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:aguas_da_borborema/src/utils/class_prevision.dart';


class MapScreen extends StatelessWidget {

  final List<PrevisaoAlagamento> previsoes;

  const MapScreen({
    super.key,
    required this.previsoes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mapa de Previsão'),
        backgroundColor: const Color(0xFF0b2351),
      ),
      backgroundColor: const Color(0xFF0b2351),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Os pontos em destaque sofreram alagamentos!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Container(
              width: 600,
              height: 600,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(-7.2307, -35.8811), // Campina Grande fixo
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.exemplo.aguasdaborborema',
                    ),
                    MarkerLayer(
                      markers: previsoes.map((p) {
                        return Marker(
                          point: LatLng(p.latitude, p.longitude),
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.warning_rounded,
                            color: _corGravidade(p.gravidade),
                            size: 36,
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
            const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.warning_rounded, color: Colors.green, size: 18),
                    SizedBox(width: 1),
                    Text('Gravidade Baixa;', style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
                    Icon(Icons.warning_rounded, color: Colors.amber, size: 18),
                    SizedBox(width: 1),
                    Text('Gravidade Média;', style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
                    Icon(Icons.warning_rounded, color: Colors.red, size: 18),
                    SizedBox(width: 1),
                    Text('Gravidade Alta', style: TextStyle(color: Colors.white70), textAlign: TextAlign.center),
                  ],
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }

  Color _corGravidade(String gravidade) {
  switch (gravidade.toLowerCase()) {
    case 'baixa':
      return Colors.green;
    case 'media':
      return Colors.amber;
    case 'alta':
      return Colors.red;
    default:
      return Colors.grey;
  }
  }
}
