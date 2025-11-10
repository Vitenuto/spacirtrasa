// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/poi/sorted_poi.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SortedPoiProvider)
const sortedPoiProvider = SortedPoiProviderProvider._();

final class SortedPoiProviderProvider
    extends $NotifierProvider<SortedPoiProvider, List<PoiWithDistance>> {
  const SortedPoiProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortedPoiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortedPoiProviderHash();

  @$internal
  @override
  SortedPoiProvider create() => SortedPoiProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PoiWithDistance> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PoiWithDistance>>(value),
    );
  }
}

String _$sortedPoiProviderHash() => r'cd082409e9dfe9c3d274181bdaf62bb228592d97';

abstract class _$SortedPoiProvider extends $Notifier<List<PoiWithDistance>> {
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
