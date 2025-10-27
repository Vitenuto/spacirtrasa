import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '../generated/map_entity/is_following.g.dart';

@riverpod
class IsFollowingProvider extends _$IsFollowingProvider {
  static final _log = Logger();

  @override
  AlignOnUpdate build() {
    _log.t("Building IsFollowing provider...");
    return AlignOnUpdate.once;
  }

  void setIsFollowing(AlignOnUpdate alignOnUpdate) {
    if (state == alignOnUpdate) return;

    _log.t("Setting isFollowing to: $alignOnUpdate");
    state = alignOnUpdate;
  }
}
