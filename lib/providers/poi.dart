import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/poi.dart';
import '../services/map_entity/poi_service.dart';

part 'generated/poi.g.dart';

@riverpod
class PoiProvider extends _$PoiProvider {
  static final log = Logger();

  @override
  List<Poi> build() {
    log.t("Building POI provider...");
    final poiSubscription = PoiService().entityCollectionStream.listen(poiListener);
    ref.onDispose(() => poiSubscription.cancel());
    return List.empty();
  }

  void poiListener(List<Poi> pois) {
    log.t("POIs were updated: $pois");
    pois.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // sort by being newest first
    state = pois;
  }
}
