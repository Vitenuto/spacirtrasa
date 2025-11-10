import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/finished_trail.dart';
import 'package:spacirtrasa/providers/user/app_user.dart';

part '../../generated/map_entity/trail/finished_trails.g.dart';

@riverpod
class FinishedTrailsProvider extends _$FinishedTrailsProvider {
  static final _log = Logger();

  @override
  List<FinishedTrail> build() {
    _log.t("Building FinishedTrails provider...");
    final appUser = ref.watch(appUserProvider);
    return appUser.finishedTrails;
  }
}
