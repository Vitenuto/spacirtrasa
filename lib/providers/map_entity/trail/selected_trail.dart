import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';

part '../../generated/map_entity/trail/selected_trail.g.dart';

@riverpod
class SelectedTrailProvider extends _$SelectedTrailProvider {
  static final log = Logger();

  @override
  Trail? build() {
    log.t("Building SelectedTrail provider...");
    return null;
  }

  void setSelected(Trail? trail) {
    log.t("Setting selected Trail: ${trail?.title}");
    state = trail;
  }
}