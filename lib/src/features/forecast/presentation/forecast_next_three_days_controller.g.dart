// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_next_three_days_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ForecastNextThreeDaysController)
const forecastNextThreeDaysControllerProvider =
    ForecastNextThreeDaysControllerProvider._();

final class ForecastNextThreeDaysControllerProvider
    extends $AsyncNotifierProvider<ForecastNextThreeDaysController,
        List<PrevisaoAlagamentoCompleta>> {
  const ForecastNextThreeDaysControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'forecastNextThreeDaysControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$forecastNextThreeDaysControllerHash();

  @$internal
  @override
  ForecastNextThreeDaysController create() => ForecastNextThreeDaysController();
}

String _$forecastNextThreeDaysControllerHash() =>
    r'18ddb0825bc4b69907ac982ddb52b78379fdbf28';

abstract class _$ForecastNextThreeDaysController
    extends $AsyncNotifier<List<PrevisaoAlagamentoCompleta>> {
  FutureOr<List<PrevisaoAlagamentoCompleta>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<PrevisaoAlagamentoCompleta>>,
        List<PrevisaoAlagamentoCompleta>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PrevisaoAlagamentoCompleta>>,
            List<PrevisaoAlagamentoCompleta>>,
        AsyncValue<List<PrevisaoAlagamentoCompleta>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
