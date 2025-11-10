// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/trail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TrailProvider)
const trailProvider = TrailProviderProvider._();

final class TrailProviderProvider
    extends $NotifierProvider<TrailProvider, List<Trail>> {
  const TrailProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trailProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trailProviderHash();

  @$internal
  @override
  TrailProvider create() => TrailProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Trail> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Trail>>(value),
    );
  }
}

String _$trailProviderHash() => r'623d05fa3035ae101558f61268243cd132e07e48';

abstract class _$TrailProvider extends $Notifier<List<Trail>> {
  List<Trail> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Trail>, List<Trail>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Trail>, List<Trail>>,
              List<Trail>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
