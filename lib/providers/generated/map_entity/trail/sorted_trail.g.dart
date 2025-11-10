// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/sorted_trail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SortedTrailProvider)
const sortedTrailProvider = SortedTrailProviderProvider._();

final class SortedTrailProviderProvider
    extends $NotifierProvider<SortedTrailProvider, List<TrailWithDetails>> {
  const SortedTrailProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sortedTrailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sortedTrailProviderHash();

  @$internal
  @override
  SortedTrailProvider create() => SortedTrailProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TrailWithDetails> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TrailWithDetails>>(value),
    );
  }
}

String _$sortedTrailProviderHash() =>
    r'cf7e1a3470022c36875f00a5744ad3bf58d31d48';

abstract class _$SortedTrailProvider extends $Notifier<List<TrailWithDetails>> {
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
