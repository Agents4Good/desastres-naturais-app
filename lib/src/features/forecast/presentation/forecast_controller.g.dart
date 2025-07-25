// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ForecastController)
const forecastControllerProvider = ForecastControllerProvider._();

final class ForecastControllerProvider
    extends $AsyncNotifierProvider<ForecastController, void> {
  const ForecastControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'forecastControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$forecastControllerHash();

  @$internal
  @override
  ForecastController create() => ForecastController();
}

String _$forecastControllerHash() =>
    r'b69da517c69fcf3b30015fc26a897fd100f33bc5';

abstract class _$ForecastController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    build();
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<void>, void>,
        AsyncValue<void>,
        Object?,
        Object?>;
    element.handleValue(ref, null);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
