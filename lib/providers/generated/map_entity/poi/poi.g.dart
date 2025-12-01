// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/poi/poi.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PoiProvider)
const poiProvider = PoiProviderProvider._();

final class PoiProviderProvider
    extends $NotifierProvider<PoiProvider, List<Poi>> {
  const PoiProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'poiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$poiProviderHash();

  @$internal
  @override
  PoiProvider create() => PoiProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Poi> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Poi>>(value),
    );
  }
}

String _$poiProviderHash() => r'32d7fdd8a32baa7f5c7d96a74966ec4997f35963';

abstract class _$PoiProvider extends $Notifier<List<Poi>> {
  List<Poi> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Poi>, List<Poi>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Poi>, List<Poi>>,
              List<Poi>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
