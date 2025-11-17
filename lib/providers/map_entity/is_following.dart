import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../generated/map_entity/is_following.g.dart';

@riverpod
class IsFollowingProvider extends _$IsFollowingProvider {
  @override
  AlignOnUpdate build() {
    logger.t("Building IsFollowing provider...");
    return AlignOnUpdate.once;
  }

  void setIsFollowing(AlignOnUpdate alignOnUpdate) {
    if (state == alignOnUpdate) return;

    logger.t("Setting isFollowing to: $alignOnUpdate");
    state = alignOnUpdate;
  }
}
