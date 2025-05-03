import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:remove_markdown/remove_markdown.dart';

enum MapEntityType { poi, trail }

abstract class MapEntity {
  String get id;
  String get title;

  String? get imgUrl;

  String get markdownData;
  String get markdownLessData {
    final whitespaceRE = RegExp(r"(?! )\s+| \s+");
    final markdownLessData = markdownData.removeMarkdown(useImgAltText: false, replaceLinksWithURL: false);
    return markdownLessData.replaceAll(whitespaceRE, " ");
  }
  Timestamp get createdAt;

  Icon get icon;

  Map<String, dynamic> toJson();
}