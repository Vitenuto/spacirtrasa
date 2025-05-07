import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_filter.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flags.dart';

part '../../generated/map_entity/poi/poi_filter.g.dart';

@riverpod
class PoiFilterProvider extends _$PoiFilterProvider {
  static final log = Logger();

  @override
  PoiFilter build() {
    log.t("Building PoiFilter provider...");
    return PoiFilter(
      flags: {},
      searchText: "",
    );
  }

  void setFilter({String? searchText, Set<PoiFlags>? flags}) {
    state = state.copyWith(
      searchText: searchText ?? state.searchText,
      flags: flags ?? state.flags,
    );
  }
}
