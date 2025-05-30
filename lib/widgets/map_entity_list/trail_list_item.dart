import 'package:spacirtrasa/models/map_entity/trail/trail_with_length.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';

class TrailListItem extends ListItem {
  final TrailWithLength trailWithLength;

  TrailListItem({
    required this.trailWithLength,
    required super.isSelected,
    required super.isPinned,
    required super.onSelected,
    required super.onShowDetail,
    super.onLongPress,
  });

  @override
  String get id => trailWithLength.trail.id;

  @override
  String get title => trailWithLength.trail.title;

  @override
  String get subtitle => '(${(trailWithLength.length / 1000).toStringAsFixed(2)} km)';

  @override
  String get description => trailWithLength.trail.markdownLessData;

  @override
  String? get imageUrl => null;
}
