// import 'dart:async';

// import 'package:pluvia/src/features/forecast/application/forecast_service.dart';
// import 'package:pluvia/src/features/forecast/domain/model_full_forecast.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';

// part 'forecast_controller.g.dart';

// @riverpod
// class ForecastController extends _$ForecastController {

//   @override
//   FutureOr<void> build() async {
//     await refreshForecasts();
//   }

//   ForecastService get _forecastService => ref.read(forecastServiceProvider as ProviderListenable<ForecastService>);

//   Future<void> refreshForecasts() async {
//     state = const AsyncLoading();
//     final result = await AsyncValue.guard(() async {
//       return _forecastService.fetchPrevisoesCompletas();
//     });
//     state = result;
//   }
// }