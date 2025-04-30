import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/finished_trail.dart';

import 'app_user.dart';

part 'generated/finished_trails.g.dart';

@riverpod
class FinishedTrailsProvider extends _$FinishedTrailsProvider {
  static final log = Logger();

  @override
  List<FinishedTrail> build() {
    log.t("Building MapEntity provider...");
    final appUser = ref.watch(appUserProvider);
    if (appUser == null) return List.empty();

    return appUser.finishedTrails;
  }
}
