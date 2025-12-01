// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/trail_filter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrailFilterProvider)
const trailFilterProvider = TrailFilterProviderProvider._();

final class TrailFilterProviderProvider
    extends $NotifierProvider<TrailFilterProvider, TrailFilter> {
  const TrailFilterProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trailFilterProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trailFilterProviderHash();

  @$internal
  @override
  TrailFilterProvider create() => TrailFilterProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrailFilter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrailFilter>(value),
    );
  }
}

String _$trailFilterProviderHash() =>
    r'4ccb45b65bce0d8e4d7edc8a0c4440987a38a096';

abstract class _$TrailFilterProvider extends $Notifier<TrailFilter> {
  TrailFilter build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<TrailFilter, TrailFilter>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<TrailFilter, TrailFilter>,
              TrailFilter,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
