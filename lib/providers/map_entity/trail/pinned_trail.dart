import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';

part '../../generated/map_entity/trail/pinned_trail.g.dart';

@Riverpod(keepAlive: true)
class PinnedTrailProvider extends _$PinnedTrailProvider {
  static final _log = Logger();

  @override
  Trail? build() {
    ref.keepAlive();
    _log.t("Building PinnedTrail provider...");
    return null;
  }

  bool togglePinned(Trail? trail) {
    if (state?.id == trail?.id) {
      _log.t("Unpinning trail");
      state = null;
      return false;
    }

    _log.t("Pinning Trail: ${trail?.title}");
    state = trail;
    return true;
  }
}
