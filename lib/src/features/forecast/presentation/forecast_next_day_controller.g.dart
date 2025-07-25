// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_next_day_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ForecastNextDayController)
const forecastNextDayControllerProvider = ForecastNextDayControllerProvider._();

final class ForecastNextDayControllerProvider extends $AsyncNotifierProvider<
    ForecastNextDayController, PrevisaoAlagamentoCompleta> {
  const ForecastNextDayControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'forecastNextDayControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$forecastNextDayControllerHash();

  @$internal
  @override
  ForecastNextDayController create() => ForecastNextDayController();
}

String _$forecastNextDayControllerHash() =>
    r'a5fcee940256e9185ed1467cd85068ee5f1d89d8';

abstract class _$ForecastNextDayController
    extends $AsyncNotifier<PrevisaoAlagamentoCompleta> {
  FutureOr<PrevisaoAlagamentoCompleta> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<PrevisaoAlagamentoCompleta>,
        PrevisaoAlagamentoCompleta>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PrevisaoAlagamentoCompleta>,
            PrevisaoAlagamentoCompleta>,
        AsyncValue<PrevisaoAlagamentoCompleta>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
