import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/trail/selected_trail.g.dart';

@Riverpod(keepAlive: true)
class SelectedTrailProvider extends _$SelectedTrailProvider {
  @override
  Trail? build() {
    ref.keepAlive();
    logger.t("Building SelectedTrail provider...");
    return null;
  }

  void setSelected(Trail? trail) {
    logger.t("Setting selected Trail: ${trail?.title}");
    state = trail;
  }
}
