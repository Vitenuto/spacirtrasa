import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';

class PoiListItem extends ListItem {
  final PoiWithDistance poiWithDistance;

  PoiListItem({
    required this.poiWithDistance,
    required super.isSelected,
    required super.isPinned,
    required super.onSelected,
    required super.onShowDetail,
    super.onLongPress,
  });

  @override
  String get id => poiWithDistance.poi.id;

  @override
  String get title => poiWithDistance.poi.title;

  @override
  String? get subtitle => poiWithDistance.distance != null ? '(${(poiWithDistance.distance! / 1000).toStringAsFixed(2)} km)' : null;

  @override
  String get description => poiWithDistance.poi.markdownLessData;

  @override
  String? get imageUrl => poiWithDistance.poi.imgUrl;
}
