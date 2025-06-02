import 'package:spacirtrasa/models/map_entity/trail/trail_with_details.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';

class TrailListItem extends ListItem {
  final TrailWithDetails trailWithDistance;

  TrailListItem({
    required this.trailWithDistance,
    required super.isSelected,
    required super.isPinned,
    required super.onSelected,
    required super.onShowDetail,
    super.onLongPress,
  });

  @override
  String get id => trailWithDistance.trail.id;

  @override
  String get title => trailWithDistance.trail.title;

  @override
  String get subtitle => '(${(trailWithDistance.length / 1000).toStringAsFixed(2)} km)';

  @override
  String get description => trailWithDistance.trail.markdownLessData;

  @override
  String? get imageUrl => null;
}
