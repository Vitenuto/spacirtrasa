import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi_with_distance.dart';

part '../../generated/map_entity/poi/sorted_poi.g.dart';

@riverpod
class SortedPoiProvider extends _$SortedPoiProvider {
  static final log = Logger();

  @override
  List<PoiWithDistance> build() {
    log.t("Building SortedPoi provider...");
    final poisWithDistances = ref.watch(poiWithDistanceProvider);
    return poisWithDistances..sort((a, b) => a.distance.compareTo(b.distance));
  }
}
