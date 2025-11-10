// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/finished_trails.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FinishedTrailsProvider)
const finishedTrailsProvider = FinishedTrailsProviderProvider._();

final class FinishedTrailsProviderProvider
    extends $NotifierProvider<FinishedTrailsProvider, List<FinishedTrail>> {
  const FinishedTrailsProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'finishedTrailsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$finishedTrailsProviderHash();

  @$internal
  @override
  FinishedTrailsProvider create() => FinishedTrailsProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<FinishedTrail> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<FinishedTrail>>(value),
    );
  }
}

String _$finishedTrailsProviderHash() =>
    r'aaeeb55e73d4624383edf8f72e70a81050ca1bb3';

abstract class _$FinishedTrailsProvider extends $Notifier<List<FinishedTrail>> {
  List<FinishedTrail> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<FinishedTrail>, List<FinishedTrail>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<FinishedTrail>, List<FinishedTrail>>,
              List<FinishedTrail>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
