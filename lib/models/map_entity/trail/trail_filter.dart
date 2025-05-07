import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_flags.dart';

part '../../generated/map_entity/trail/trail_filter.freezed.dart';

@freezed
abstract class TrailFilter with _$TrailFilter {
  const factory TrailFilter({
    required (double, double) bounds,
    required String searchText,
    required List<TrailFlags> flags,
  }) = _TrailFilter;
}
