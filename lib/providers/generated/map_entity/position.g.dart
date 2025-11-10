// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../map_entity/position.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PositionProvider)
const positionProvider = PositionProviderProvider._();

final class PositionProviderProvider
    extends $NotifierProvider<PositionProvider, Position?> {
  const PositionProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'positionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$positionProviderHash();

  @$internal
  @override
  PositionProvider create() => PositionProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Position? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Position?>(value),
    );
  }
}

String _$positionProviderHash() => r'64a5cf3264b50041071fc60fd282845ba3fe213f';

abstract class _$PositionProvider extends $Notifier<Position?> {
  Position? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Position?, Position?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Position?, Position?>,
              Position?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
