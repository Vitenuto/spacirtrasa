import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi_with_distance.dart';

part '../../generated/map_entity/poi/sorted_poi.g.dart';

@Riverpod(keepAlive: true)
class SortedPoiProvider extends _$SortedPoiProvider {
  static final _log = Logger();

  @override
  List<PoiWithDistance> build() {
    _log.t("Building SortedPoi provider...");
    final poisWithDistances = ref.watch(poiWithDistanceProvider);
    return poisWithDistances..sort();
  }
}
