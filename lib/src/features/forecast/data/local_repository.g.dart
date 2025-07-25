// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(ForecastLocalRepository)
const forecastLocalRepositoryProvider = ForecastLocalRepositoryProvider._();

final class ForecastLocalRepositoryProvider extends $NotifierProvider<
    ForecastLocalRepository, ForecastLocalRepository> {
  const ForecastLocalRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'forecastLocalRepositoryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$forecastLocalRepositoryHash();

  @$internal
  @override
  ForecastLocalRepository create() => ForecastLocalRepository();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ForecastLocalRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ForecastLocalRepository>(value),
    );
  }
}

String _$forecastLocalRepositoryHash() =>
    r'e1eb33cd0ad6051773826bc58c6fca59c663614d';

abstract class _$ForecastLocalRepository
    extends $Notifier<ForecastLocalRepository> {
  ForecastLocalRepository build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<ForecastLocalRepository, ForecastLocalRepository>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<ForecastLocalRepository, ForecastLocalRepository>,
        ForecastLocalRepository,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
