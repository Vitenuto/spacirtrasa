import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_filter.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_flags.dart';

part '../../generated/map_entity/trail/trail_filter.g.dart';

@riverpod
class TrailFilterProvider extends _$TrailFilterProvider {
  static final log = Logger();

  @override
  TrailFilter build() {
    log.t("Building TrailFilter provider...");
    return TrailFilter(
      flags: {},
      bounds: (double.negativeInfinity, double.infinity),
      searchText: "",
    );
  }

  void setFilter({(double, double)? bounds, String? searchText, Set<TrailFlags>? flags}) {
    state = state.copyWith(
      bounds: bounds ?? state.bounds,
      searchText: searchText ?? state.searchText,
      flags: flags ?? state.flags,
    );
  }
}
