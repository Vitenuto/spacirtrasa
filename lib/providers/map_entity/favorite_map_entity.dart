import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';
import 'package:spacirtrasa/providers/user/app_user.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../generated/map_entity/favorite_map_entity.g.dart';

@riverpod
class FavoriteMapEntityProvider extends _$FavoriteMapEntityProvider {
  @override
  List<MapEntity> build() {
    logger.t("Building MapEntity provider...");
    final pois = ref.watch(poiProvider);
    final trails = ref.watch(trailProvider);
    final appUser = ref.watch(appUserProvider);
    return _getFavoriteMapEntities(pois, appUser, trails);
  }

  List<MapEntity> _getFavoriteMapEntities(List<Poi> pois, AppUser appUser, List<Trail> trails) {
    final List<MapEntity> mapEntities = List.empty(growable: true);
    final favoritePois =
        pois.where((poi) => appUser.favoritePoiIds.contains(poi.id)).toList() as List<MapEntity>;
    final favoriteTrails =
        trails.where((trail) => appUser.favoriteTrailIds.contains(trail.id)).toList()
            as List<MapEntity>;
    mapEntities.addAll(favoritePois);
    mapEntities.addAll(favoriteTrails);
    return mapEntities;
  }
}
