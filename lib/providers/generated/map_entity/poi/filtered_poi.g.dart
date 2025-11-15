// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/poi/filtered_poi.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FilteredPoiProvider)
const filteredPoiProvider = FilteredPoiProviderProvider._();

final class FilteredPoiProviderProvider
    extends $NotifierProvider<FilteredPoiProvider, List<PoiWithDistance>> {
  const FilteredPoiProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredPoiProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredPoiProviderHash();

  @$internal
  @override
  FilteredPoiProvider create() => FilteredPoiProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<PoiWithDistance> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<PoiWithDistance>>(value),
    );
  }
}

String _$filteredPoiProviderHash() =>
    r'150df5313f6e24ab78a30f6419464a0ddb4b4353';

abstract class _$FilteredPoiProvider extends $Notifier<List<PoiWithDistance>> {
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
