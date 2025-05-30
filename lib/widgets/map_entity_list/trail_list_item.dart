import 'dart:ui';

import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';

class TrailListItem implements ListItem {
  final Trail trail;
  final bool isSelected;
  final bool isPinned;
  final VoidCallback onSelected;
  final VoidCallback onShowDetail;
  final VoidCallback? onLongPress;

  TrailListItem({
    required this.trail,
    required this.isSelected,
    required this.isPinned,
    required this.onSelected,
    required this.onShowDetail,
    this.onLongPress,
  });

  @override
  String get id => trail.id;

  @override
  String get title => trail.title;

  @override
  String get subtitle => '(${(trail.path.toLength() / 1000).toStringAsFixed(2)} km)';

  @override
  String get description => trail.markdownLessData;

  @override
  String? get imageUrl => null;
}
