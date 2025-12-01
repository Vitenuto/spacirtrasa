// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/trail/selected_trail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedTrailProvider)
const selectedTrailProvider = SelectedTrailProviderProvider._();

final class SelectedTrailProviderProvider
    extends $NotifierProvider<SelectedTrailProvider, Trail?> {
  const SelectedTrailProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTrailProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTrailProviderHash();

  @$internal
  @override
  SelectedTrailProvider create() => SelectedTrailProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Trail? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Trail?>(value),
    );
  }
}

String _$selectedTrailProviderHash() =>
    r'47c7704877b6042077ae7d165199df772d5949c3';

abstract class _$SelectedTrailProvider extends $Notifier<Trail?> {
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
