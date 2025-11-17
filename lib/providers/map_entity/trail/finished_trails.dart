import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/finished_trail.dart';
import 'package:spacirtrasa/providers/user/app_user.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/trail/finished_trails.g.dart';

@riverpod
class FinishedTrailsProvider extends _$FinishedTrailsProvider {
  @override
  List<FinishedTrail> build() {
    logger.t("Building FinishedTrails provider...");
    final appUser = ref.watch(appUserProvider);
    return appUser.finishedTrails;
  }
}
