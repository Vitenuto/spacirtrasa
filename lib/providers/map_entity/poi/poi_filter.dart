import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_filter.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flag.dart';

part '../../generated/map_entity/poi/poi_filter.g.dart';

@riverpod
class PoiFilterProvider extends _$PoiFilterProvider {
  static final _log = Logger();

  @override
  PoiFilter build() {
    _log.t("Building PoiFilter provider...");
    return PoiFilter(flag: null, searchText: "");
  }

  void setFilter({String? searchText, PoiFlag? flag}) {
    final PoiFlag? newFlag;
    if (flag == null) {
      newFlag = state.flag;
    } else if (flag == state.flag) {
      newFlag = null;
    } else {
      newFlag = flag;
    }

    state = state.copyWith(searchText: searchText ?? state.searchText, flag: newFlag);
  }
}
