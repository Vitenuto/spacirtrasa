import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/trail/pinned_trail.g.dart';

@Riverpod(keepAlive: true)
class PinnedTrailProvider extends _$PinnedTrailProvider {
  @override
  Trail? build() {
    ref.keepAlive();
    logger.t("Building PinnedTrail provider...");
    return null;
  }

  bool togglePinned(Trail? trail) {
    if (state?.id == trail?.id) {
      logger.t("Unpinning trail");
      state = null;
      return false;
    }

    logger.t("Pinning Trail: ${trail?.title}");
    state = trail;
    return true;
  }
}
