import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/poi.dart';

part 'generated/selected_poi.g.dart';

@riverpod
class SelectedPoiProvider extends _$SelectedPoiProvider {
  static final log = Logger();

  @override
  Poi? build() => null;

  void setSelected(Poi? poi) {
    log.t("Setting selected POI: ${poi?.title}");
    state = poi;
  }
}