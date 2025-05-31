import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flag.dart';

part '../../generated/map_entity/poi/poi_filter.freezed.dart';

@freezed
abstract class PoiFilter with _$PoiFilter {
  const factory PoiFilter({
    required String searchText,
    required PoiFlag? flag,
  }) = _PoiFilter;
}
