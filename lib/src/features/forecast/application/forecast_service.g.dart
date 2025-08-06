// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(forecastService)
const forecastServiceProvider = ForecastServiceProvider._();

final class ForecastServiceProvider extends $FunctionalProvider<ForecastService,
    ForecastService, ForecastService> with $Provider<ForecastService> {
  const ForecastServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'forecastServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$forecastServiceHash();

  @$internal
  @override
  $ProviderElement<ForecastService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ForecastService create(Ref ref) {
    return forecastService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForecastService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForecastService>(value),
    );
  }
}

String _$forecastServiceHash() => r'9fe2b56b0f8479885ff90f8e19de8578288bc6f5';

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
