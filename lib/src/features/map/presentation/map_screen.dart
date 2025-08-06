import 'package:intl/intl.dart';
import 'package:pluvia/src/features/forecast/domain/model_full_forecast.dart';
import 'package:pluvia/src/features/forecast/presentation/forecast_next_three_days_controller.dart';
import 'package:pluvia/src/services/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:pluvia/src/features/forecast/domain/model_forecast.dart';
import 'package:pluvia/l10n/app_localizations.dart';

// Change: Convert the widget to a ConsumerStatefulWidget to hold state.
class MapScreen extends ConsumerStatefulWidget {
  const MapScreen({super.key});

  @override
  ConsumerState<MapScreen> createState() => _MapScreenState();
}

// Change: Create a State class for our widget.
class _MapScreenState extends ConsumerState<MapScreen> {
  // Change: Add a state variable to track the current forecast index.
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    // The ref is now accessed via the 'ref' property of the State class.
    final l10n = AppLocalizations.of(context)!;
    final state = ref.watch(forecastNextThreeDaysControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navMap),
        backgroundColor: const Color(0xFF0b2351),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              // Reset index to 0 on refresh to avoid out-of-bounds errors.
              setState(() {
                _currentIndex = 0;
              });
              ref
                  .read(forecastNextThreeDaysControllerProvider.notifier)
                  .refreshNextThreeDaysForecast();
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFF0b2351),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Text(
                l10n.highlightedFloodPoints,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            // Change: Added the forecast navigator (arrows and date).
            state.when(
              data: (forecasts) {
                if (forecasts.isEmpty) {
                  return const SizedBox.shrink(); // Don't show if there's no data
                }
                return Column(children: [Text(
              l10n.mapPrevisionDate,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                        // Disable the button if we are at the first forecast
                        onPressed: _currentIndex > 0
                            ? () => setState(() => _currentIndex--)
                            : null,
                      ),
                      Text(
                        // Display the date of the currently selected forecast
                        DateFormat(l10n.dateFormatUpToDay).format(forecasts[_currentIndex].dataPrevisao),
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white),
                        // Disable the button if we are at the last forecast
                        onPressed: _currentIndex < forecasts.length - 1
                            ? () => setState(() => _currentIndex++)
                            : null,
                      ),
                    ],
                  ),
                )]);
              },
              loading: () => const Padding(
                padding: EdgeInsets.all(28.0), // Match navigator height
                child: CircularProgressIndicator(),
              ),
              error: (error, stack) => Padding(
                padding: const EdgeInsets.all(28.0),
                child: Text('Erro ao carregar previsão', style: const TextStyle(color: Colors.red)),
              ),
            ),

            Container(
              width: 600,
              height: 550, // Adjusted height to make room for the navigator
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FlutterMap(
                  options: MapOptions(
                    center: LatLng(-7.2307, -35.8811),
                    initialZoom: 13.0,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                      subdomains: const ['a', 'b', 'c'],
                      userAgentPackageName: 'com.exemplo.aguasdaborborema',
                    ),
                    FutureBuilder<List<Contact>>(
                      future: contactService.getContacts(),
                      builder: (context, snapShot) {
                        List<Contact> contacts = [];
                        if (snapShot.hasData) {
                          contacts = snapShot.data ?? [];
                        }
                        return MarkerLayer(
                          markers: [...state.when(
                            data: (previsaoAlagamentoCompleta) {
                              // Change: Ensure list is not empty and index is valid.
                              if (previsaoAlagamentoCompleta.isEmpty || _currentIndex >= previsaoAlagamentoCompleta.length) {
                                return <Marker>[];
                              }
                              // Change: Get the specific forecast based on the current index.
                              final previsoes = previsaoAlagamentoCompleta[_currentIndex].previsoes;
                              return [
                                ...previsoes.map((p) {
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
                                }),
                                ...contacts.map((c) {
                                  return Marker(
                                    point: LatLng(c.latitude, c.longitude),
                                    width: 40,
                                    height: 40,
                                    child: Icon(
                                      Icons.person_2_rounded,
                                      size: 36,
                                      color: _corContato(c.alagamentoMaisProximo(previsoes)),
                                    ),
                                  );
                                }),
                              ];
                            },
                            error: (error, stack) {
                              print('Erro ao carregar previsões: $error');
                              return <Marker>[];
                            },
                            loading: () => <Marker>[],
                          )],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.warning_rounded, color: Colors.green, size: 18),
                      const SizedBox(width: 1),
                      Text(l10n.severityLow, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      const Icon(Icons.warning_rounded, color: Colors.amber, size: 18),
                      const SizedBox(width: 1),
                      Text(l10n.severityMedium, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
                      const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
                      const Icon(Icons.warning_rounded, color: Colors.red, size: 18),
                      const SizedBox(width: 1),
                      Text(l10n.severityHigh, style: const TextStyle(color: Colors.white70), textAlign: TextAlign.center),
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

  Color _corGravidade(GravidadeAlagamento gravidade) {
    switch (gravidade) {
      case GravidadeAlagamento.baixa:
        return Colors.green;
      case GravidadeAlagamento.media:
        return Colors.amber;
      case GravidadeAlagamento.alta:
        return Colors.red;
    }
  }

  Color _corContato(GravidadeAlagamento? gravidade) {
    const cores = {
      GravidadeAlagamento.baixa: Colors.green,
      GravidadeAlagamento.media: Colors.amber,
      GravidadeAlagamento.alta: Colors.red,
    };
    return cores[gravidade] ?? Colors.blueAccent;
  }
}