// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mongo_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ForecastMongoRepository)
const forecastMongoRepositoryProvider = ForecastMongoRepositoryProvider._();

final class ForecastMongoRepositoryProvider extends $NotifierProvider<
    ForecastMongoRepository, ForecastMongoRepository> {
  const ForecastMongoRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'forecastMongoRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$forecastMongoRepositoryHash();

  @$internal
  @override
  ForecastMongoRepository create() => ForecastMongoRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForecastMongoRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForecastMongoRepository>(value),
    );
  }
}

String _$forecastMongoRepositoryHash() =>
    r'83fec1667b8463033772bd20180c49991e5fdc87';

abstract class _$ForecastMongoRepository
    extends $Notifier<ForecastMongoRepository> {
  ForecastMongoRepository build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<ForecastMongoRepository, ForecastMongoRepository>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ForecastMongoRepository, ForecastMongoRepository>,
        ForecastMongoRepository,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
