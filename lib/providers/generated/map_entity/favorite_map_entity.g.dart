// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../map_entity/favorite_map_entity.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoriteMapEntityProvider)
const favoriteMapEntityProvider = FavoriteMapEntityProviderProvider._();

final class FavoriteMapEntityProviderProvider
    extends $NotifierProvider<FavoriteMapEntityProvider, List<MapEntity>> {
  const FavoriteMapEntityProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteMapEntityProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteMapEntityProviderHash();

  @$internal
  @override
  FavoriteMapEntityProvider create() => FavoriteMapEntityProvider();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<MapEntity> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<MapEntity>>(value),
    );
  }
}

String _$favoriteMapEntityProviderHash() =>
    r'265e488fae0d3dccaa4d22691080408c9e8ca5c5';

abstract class _$FavoriteMapEntityProvider extends $Notifier<List<MapEntity>> {
  List<MapEntity> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<MapEntity>, List<MapEntity>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<MapEntity>, List<MapEntity>>,
              List<MapEntity>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
