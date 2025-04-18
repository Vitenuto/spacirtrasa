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

  void poiListener(pois) {
    log.t("POIs were updated: $pois");
    state = pois;
  }
}
