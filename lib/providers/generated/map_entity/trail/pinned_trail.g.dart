// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/pinned_trail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PinnedTrailProvider)
const pinnedTrailProvider = PinnedTrailProviderProvider._();

final class PinnedTrailProviderProvider
    extends $NotifierProvider<PinnedTrailProvider, Trail?> {
  const PinnedTrailProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'pinnedTrailProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$pinnedTrailProviderHash();

  @$internal
  @override
  PinnedTrailProvider create() => PinnedTrailProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Trail? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Trail?>(value),
    );
  }
}

String _$pinnedTrailProviderHash() =>
    r'4163835ffa98da151ae4e7ede8c55b6175c3846f';

abstract class _$PinnedTrailProvider extends $Notifier<Trail?> {
  Trail? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Trail?, Trail?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Trail?, Trail?>,
              Trail?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
