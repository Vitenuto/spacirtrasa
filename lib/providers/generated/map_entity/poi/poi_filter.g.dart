// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/poi/poi_filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PoiFilterProvider)
const poiFilterProvider = PoiFilterProviderProvider._();

final class PoiFilterProviderProvider
    extends $NotifierProvider<PoiFilterProvider, PoiFilter> {
  const PoiFilterProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'poiFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$poiFilterProviderHash();

  @$internal
  @override
  PoiFilterProvider create() => PoiFilterProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PoiFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PoiFilter>(value),
    );
  }
}

String _$poiFilterProviderHash() => r'3d67ae696c0870f0a4e77913a3e01bdfa821c332';

abstract class _$PoiFilterProvider extends $Notifier<PoiFilter> {
  PoiFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<PoiFilter, PoiFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<PoiFilter, PoiFilter>,
              PoiFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
