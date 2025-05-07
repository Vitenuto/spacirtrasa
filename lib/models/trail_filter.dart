import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:spacirtrasa/models/trail_flags.dart';

part 'generated/trail_filter.freezed.dart';

@freezed
abstract class TrailFilter with _$TrailFilter {
  const factory TrailFilter({
    required (double, double) bounds,
    required String searchText,
    required List<TrailFlags> flags,
  }) = _TrailFilter;
}
