import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/finished_trail.dart';
import 'package:spacirtrasa/providers/app_user.dart';

part '../../generated/map_entity/trail/finished_trails.g.dart';

@riverpod
class FinishedTrailsProvider extends _$FinishedTrailsProvider {
  static final log = Logger();

  @override
  List<FinishedTrail> build() {
    log.t("Building FinishedTrails provider...");
    final appUser = ref.watch(appUserProvider);
    if (appUser == null) return List.empty();

    return appUser.finishedTrails;
  }
}
