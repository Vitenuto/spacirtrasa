import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/services/map_entity/trail.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/trail/trail.g.dart';

@Riverpod(keepAlive: true)
class TrailProvider extends _$TrailProvider {
  @override
  List<Trail> build() {
    ref.keepAlive();
    logger.t("Building Trail provider...");
    final trailSubscription = TrailService().entityCollectionStream.listen(_onTrailUpdate);
    ref.onDispose(() => trailSubscription.cancel());
    return List.empty();
  }

  void _onTrailUpdate(List<Trail> trails) {
    logger.t("Trails were updated: ${trails.map((trail) => trail.title)}");
    state = trails;
  }
}
