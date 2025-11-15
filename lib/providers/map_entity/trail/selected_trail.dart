import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';

part '../../generated/map_entity/trail/selected_trail.g.dart';

@Riverpod(keepAlive: true)
class SelectedTrailProvider extends _$SelectedTrailProvider {
  static final _log = Logger();

  @override
  Trail? build() {
    ref.keepAlive();
    _log.t("Building SelectedTrail provider...");
    return null;
  }

  void setSelected(Trail? trail) {
    _log.t("Setting selected Trail: ${trail?.title}");
    state = trail;
  }
}
