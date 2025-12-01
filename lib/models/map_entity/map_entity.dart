import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:remove_markdown/remove_markdown.dart';

enum MapEntityType { poi, trail }

abstract class MapEntity {
  String get id;

  Map<String, String> get title;

  String get titleLocalized => title['language.code'.tr()] ?? title.values.first;

  String? get imgUrl;

  Map<String, String> get markdownData;

  String get markdownDataLocalized =>
      markdownData['language.code'.tr()] ?? markdownData.values.first;

  String get markdownLessDataLocalized {
    final whitespaceRE = RegExp(r"(?! )\s+| \s+");
    final markdownLessData = markdownDataLocalized.removeMarkdown(
      useImgAltText: false,
      replaceLinksWithURL: false,
    );
    return markdownLessData.replaceAll(whitespaceRE, " ");
  }

  Timestamp get createdAt;

  String get createdAtFormatted => DateFormat.yMMMd().add_Hms().format(createdAt.toDate());

  Icon get icon;

  Map<String, dynamic> toJson();
}
