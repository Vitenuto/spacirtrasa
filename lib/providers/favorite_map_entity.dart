import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/providers/poi.dart';
import 'package:spacirtrasa/providers/trail.dart';

import '../models/map_entity.dart';
import 'app_user.dart';

part 'generated/favorite_map_entity.g.dart';

@riverpod
class FavoriteMapEntityProvider extends _$FavoriteMapEntityProvider {
  static final log = Logger();

  @override
  List<MapEntity> build() {
    log.t("Building MapEntity provider...");
    final pois = ref.watch(poiProvider);
    final trails = ref.watch(trailProvider);
    final appUser = ref.watch(appUserProvider);
    if (appUser == null) return List.empty();

    final List<MapEntity> mapEntities = List.empty(growable: true);
    final favoritePois = pois
        .where((poi) => appUser.favoritePoiIds.contains(poi.id))
        .toList() as List<MapEntity>;
    final favoriteTrails = trails
        .where((trail) => appUser.favoriteTrailIds.contains(trail.id))
        .toList() as List<MapEntity>;
    mapEntities.addAll(favoritePois);
    mapEntities.addAll(favoriteTrails);
    return mapEntities;
  }
}
