import 'dart:async';

import 'package:aguas_da_borborema/src/features/forecast/application/forecast_service.dart';
import 'package:aguas_da_borborema/src/features/forecast/domain/model_full_forecast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forecast_next_day_controller.g.dart';

@riverpod
class ForecastNextDayController extends _$ForecastNextDayController {

  @override
  Future<PrevisaoAlagamentoCompleta> build() async {
    final forecastService = ref.read(forecastServiceProvider);
    final tomorrow = DateTime.now().add(const Duration(days: 1));

    var _timer = Timer.periodic(const Duration(minutes: 15), (timer) {
      refreshNextDayForecast();
    });

    ref.onDispose(() {
      _timer.cancel();
    });

    return forecastService.fetchCurrentPrevisaoCompleta(tomorrow);
  }

  /// Manually triggers a refresh of the forecast data.
  Future<void> refreshNextDayForecast() async {
    // 1. Set the state to loading to immediately show a progress indicator in the UI.
    state = const AsyncValue.loading();

    // 2. Re-fetch the data inside a guard. This safely handles success and error cases.
    state = await AsyncValue.guard(() {
      final forecastService = ref.read(forecastServiceProvider);
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      return forecastService.fetchCurrentPrevisaoCompleta(tomorrow);
    });
  }
}