// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/poi/poi_with_distance.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PoiWithDistanceProvider)
const poiWithDistanceProvider = PoiWithDistanceProviderProvider._();

final class PoiWithDistanceProviderProvider
    extends $NotifierProvider<PoiWithDistanceProvider, List<PoiWithDistance>> {
  const PoiWithDistanceProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'poiWithDistanceProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$poiWithDistanceProviderHash();

  @$internal
  @override
  PoiWithDistanceProvider create() => PoiWithDistanceProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PoiWithDistance> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PoiWithDistance>>(value),
    );
  }
}

String _$poiWithDistanceProviderHash() =>
    r'0381f48b35652ffbe4a95c8639ef700bc61e23c0';

abstract class _$PoiWithDistanceProvider
    extends $Notifier<List<PoiWithDistance>> {
  List<PoiWithDistance> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<PoiWithDistance>, List<PoiWithDistance>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<PoiWithDistance>, List<PoiWithDistance>>,
              List<PoiWithDistance>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
