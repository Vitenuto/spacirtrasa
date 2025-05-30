import 'dart:ui';

abstract class ListItem {
  final bool isSelected;
  final bool isPinned;
  final VoidCallback onSelected;
  final VoidCallback onShowDetail;
  final VoidCallback? onLongPress;

  const ListItem({
    required this.isSelected,
    required this.isPinned,
    required this.onSelected,
    required this.onShowDetail,
    this.onLongPress,
  });

  String get id;

  String get title;

  String? get subtitle;

  String get description;

  String? get imageUrl;
}
