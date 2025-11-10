// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/filtered_trail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FilteredTrailProvider)
const filteredTrailProvider = FilteredTrailProviderProvider._();

final class FilteredTrailProviderProvider
    extends $NotifierProvider<FilteredTrailProvider, List<TrailWithDetails>> {
  const FilteredTrailProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredTrailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredTrailProviderHash();

  @$internal
  @override
  FilteredTrailProvider create() => FilteredTrailProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TrailWithDetails> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TrailWithDetails>>(value),
    );
  }
}

String _$filteredTrailProviderHash() =>
    r'1d23857dc4349f18dee11cb3adcc91bd6ae13196';

abstract class _$FilteredTrailProvider
    extends $Notifier<List<TrailWithDetails>> {
  List<TrailWithDetails> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<TrailWithDetails>, List<TrailWithDetails>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<TrailWithDetails>, List<TrailWithDetails>>,
              List<TrailWithDetails>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
