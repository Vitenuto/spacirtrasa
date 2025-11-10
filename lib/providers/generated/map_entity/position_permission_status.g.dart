// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../map_entity/position_permission_status.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PositionPermissionStatusProvider)
const positionPermissionStatusProvider =
    PositionPermissionStatusProviderProvider._();

final class PositionPermissionStatusProviderProvider
    extends
        $NotifierProvider<PositionPermissionStatusProvider, ServiceStatus?> {
  const PositionPermissionStatusProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'positionPermissionStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$positionPermissionStatusProviderHash();

  @$internal
  @override
  PositionPermissionStatusProvider create() =>
      PositionPermissionStatusProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ServiceStatus? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ServiceStatus?>(value),
    );
  }
}

String _$positionPermissionStatusProviderHash() =>
    r'3aae8acf0173d271f74bd471b9aaf5f14b0b59ab';

abstract class _$PositionPermissionStatusProvider
    extends $Notifier<ServiceStatus?> {
  ServiceStatus? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ServiceStatus?, ServiceStatus?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ServiceStatus?, ServiceStatus?>,
              ServiceStatus?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
