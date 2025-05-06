import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/trail.dart';
import 'package:spacirtrasa/services/map_entity/trail.dart';

part '../generated/map_entity/trail.g.dart';

@riverpod
class TrailProvider extends _$TrailProvider {
  static final log = Logger();

  @override
  List<Trail> build() {
    log.t("Building POI provider...");
    final trailSubscription = TrailService().entityCollectionStream.listen(trailListener);
    ref.onDispose(() => trailSubscription.cancel());
    return List.empty();
  }

  void trailListener(List<Trail> trails) {
    log.t("POIs were updated: $trails");
    trails.sort((a, b) => b.createdAt.compareTo(a.createdAt)); // sort by being newest first
    state = trails;
  }
}
