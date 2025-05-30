import 'dart:ui';

abstract class ListItem {
  String get id;

  String get title;

  String get subtitle;

  String get description;

  String? get imageUrl;

  bool get isPinned;

  bool get isSelected;

  VoidCallback get onSelected;

  VoidCallback get onShowDetail;

  VoidCallback? get onLongPress;
}
