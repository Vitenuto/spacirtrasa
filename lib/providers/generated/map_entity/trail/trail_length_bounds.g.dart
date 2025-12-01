// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/trail_length_bounds.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrailLengthBoundsProvider)
const trailLengthBoundsProvider = TrailLengthBoundsProviderProvider._();

final class TrailLengthBoundsProviderProvider
    extends $NotifierProvider<TrailLengthBoundsProvider, (double, double)?> {
  const TrailLengthBoundsProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trailLengthBoundsProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trailLengthBoundsProviderHash();

  @$internal
  @override
  TrailLengthBoundsProvider create() => TrailLengthBoundsProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue((double, double)? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<(double, double)?>(value),
    );
  }
}

String _$trailLengthBoundsProviderHash() =>
    r'59ff20c5eb0755f94a8b795c49d14a752bb3b00a';

abstract class _$TrailLengthBoundsProvider
    extends $Notifier<(double, double)?> {
  (double, double)? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<(double, double)?, (double, double)?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<(double, double)?, (double, double)?>,
              (double, double)?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
