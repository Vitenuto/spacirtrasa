// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../../map_entity/poi/selected_poi.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedPoiProvider)
const selectedPoiProvider = SelectedPoiProviderProvider._();

final class SelectedPoiProviderProvider
    extends $NotifierProvider<SelectedPoiProvider, Poi?> {
  const SelectedPoiProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedPoiProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedPoiProviderHash();

  @$internal
  @override
  SelectedPoiProvider create() => SelectedPoiProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Poi? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Poi?>(value),
    );
  }
}

String _$selectedPoiProviderHash() =>
    r'e095218d7bb0ddd1a5a88a87833de4f0ca7ad9b4';

abstract class _$SelectedPoiProvider extends $Notifier<Poi?> {
  Poi? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Poi?, Poi?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Poi?, Poi?>,
              Poi?,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
