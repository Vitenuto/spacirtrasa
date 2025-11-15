import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/services/map_entity/poi.dart';

part '../../generated/map_entity/poi/poi.g.dart';

@Riverpod(keepAlive: true)
class PoiProvider extends _$PoiProvider {
  static final _log = Logger();

  @override
  List<Poi> build() {
    ref.keepAlive();
    _log.t("Building POI provider...");
    final poiSubscription = PoiService().entityCollectionStream.listen(_onPoiUpdate);
    ref.onDispose(() => poiSubscription.cancel());
    return List.empty();
  }

  void _onPoiUpdate(List<Poi> pois) {
    _log.t("${pois.length} POIs were updated");
    state = pois;
  }
}
