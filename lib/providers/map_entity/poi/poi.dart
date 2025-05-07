import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/services/map_entity/poi.dart';

part '../../generated/map_entity/poi/poi.g.dart';

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
    log.t("${pois.length} POIs were updated");
    state = pois;
  }
}
