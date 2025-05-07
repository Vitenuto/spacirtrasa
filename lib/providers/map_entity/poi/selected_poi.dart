import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';

part '../../generated/map_entity/poi/selected_poi.g.dart';

@riverpod
class SelectedPoiProvider extends _$SelectedPoiProvider {
  static final log = Logger();

  @override
  Poi? build() {
    log.t("Building SelectedPoi provider...");
    return null;
  }

  void setSelected(Poi? poi) {
    log.t("Setting selected POI: ${poi?.title}");
    state = poi;
  }
}