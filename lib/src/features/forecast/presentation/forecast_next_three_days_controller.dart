import 'dart:async';

import 'package:pluvia/src/features/forecast/application/forecast_service.dart';
import 'package:pluvia/src/features/forecast/domain/model_full_forecast.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forecast_next_three_days_controller.g.dart';

@riverpod
class ForecastNextThreeDaysController extends _$ForecastNextThreeDaysController {

  @override
  Future<List<PrevisaoAlagamentoCompleta>> build() async {
    final forecastService = ref.read(forecastServiceProvider);

    var _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
      refreshNextThreeDaysForecast();
    });

    ref.onDispose(() {
      _timer.cancel();
    });

    return forecastService.fetchCurrentPrevisaoNextThreeDays();
  }

  /// Manually triggers a refresh of the forecast data.
  Future<void> refreshNextThreeDaysForecast() async {
    // 1. Set the state to loading to immediately show a progress indicator in the UI.
    state = const AsyncValue.loading();

    // 2. Re-fetch the data inside a guard. This safely handles success and error cases.
    state = await AsyncValue.guard(() {
      final forecastService = ref.read(forecastServiceProvider);
      return forecastService.fetchCurrentPrevisaoNextThreeDays();
    });
  }
}