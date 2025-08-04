// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'last_week_notifications_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

@ProviderFor(LastWeekNotificationsController)
const lastWeekNotificationsControllerProvider =
    LastWeekNotificationsControllerProvider._();

final class LastWeekNotificationsControllerProvider
    extends $AsyncNotifierProvider<LastWeekNotificationsController,
        List<PrevisaoNotificaoCompleta>> {
  const LastWeekNotificationsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lastWeekNotificationsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lastWeekNotificationsControllerHash();

  @$internal
  @override
  LastWeekNotificationsController create() => LastWeekNotificationsController();
}

String _$lastWeekNotificationsControllerHash() =>
    r'b58a216c08c869b27cf3e59c0203a82063014114';

abstract class _$LastWeekNotificationsController
    extends $AsyncNotifier<List<PrevisaoNotificaoCompleta>> {
  FutureOr<List<PrevisaoNotificaoCompleta>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AsyncValue<List<PrevisaoNotificaoCompleta>>,
        List<PrevisaoNotificaoCompleta>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<PrevisaoNotificaoCompleta>>,
            List<PrevisaoNotificaoCompleta>>,
        AsyncValue<List<PrevisaoNotificaoCompleta>>,
        Object?,
        Object?>;
    element.handleValue(ref, created);
  }
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
