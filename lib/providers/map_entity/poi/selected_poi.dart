import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';

part '../../generated/map_entity/poi/selected_poi.g.dart';

@Riverpod(keepAlive: true)
class SelectedPoiProvider extends _$SelectedPoiProvider {
  static final _log = Logger();

  @override
  Poi? build() {
    ref.keepAlive();
    _log.t("Building SelectedPoi provider...");
    return null;
  }

  void setSelected(Poi? poi) {
    _log.t("Setting selected POI: ${poi?.title}");
    state = poi;
  }
}
