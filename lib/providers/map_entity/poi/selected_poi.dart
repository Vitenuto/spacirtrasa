import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/poi/selected_poi.g.dart';

@Riverpod(keepAlive: true)
class SelectedPoiProvider extends _$SelectedPoiProvider {
  @override
  Poi? build() {
    ref.keepAlive();
    logger.t("Building SelectedPoi provider...");
    return null;
  }

  void setSelected(Poi? poi) {
    logger.t("Setting selected POI: ${poi?.title}");
    state = poi;
  }
}
