// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/trail_with_details.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrailWithDetailsProvider)
const trailWithDetailsProvider = TrailWithDetailsProviderProvider._();

final class TrailWithDetailsProviderProvider
    extends
        $NotifierProvider<TrailWithDetailsProvider, List<TrailWithDetails>> {
  const TrailWithDetailsProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trailWithDetailsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trailWithDetailsProviderHash();

  @$internal
  @override
  TrailWithDetailsProvider create() => TrailWithDetailsProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<TrailWithDetails> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<TrailWithDetails>>(value),
    );
  }
}

String _$trailWithDetailsProviderHash() =>
    r'b372b0f6091cebb19bbbc2704298dff9337703cb';

abstract class _$TrailWithDetailsProvider
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
