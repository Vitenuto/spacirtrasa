import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_filter.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flag.dart';
import 'package:spacirtrasa/utils/utils.dart';

part '../../generated/map_entity/poi/poi_filter.g.dart';

@Riverpod(keepAlive: true)
class PoiFilterProvider extends _$PoiFilterProvider {
  @override
  PoiFilter build() {
    logger.t("Building PoiFilter provider...");
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
