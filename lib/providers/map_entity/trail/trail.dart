import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/services/map_entity/trail.dart';

part '../../generated/map_entity/trail/trail.g.dart';

@riverpod
class TrailProvider extends _$TrailProvider {
  static final log = Logger();

  @override
  List<Trail> build() {
    log.t("Building Trail provider...");
    final trailSubscription = TrailService().entityCollectionStream.listen(trailListener);
    ref.onDispose(() => trailSubscription.cancel());
    return List.empty();
  }

  void trailListener(List<Trail> trails) {
    log.t("Trails were updated: $trails");
    state = trails;
  }
}
