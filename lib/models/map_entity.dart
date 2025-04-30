import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

enum MapEntityType { poi, trail }

abstract class MapEntity {
  String get id;
  String get title;

  String? get imgUrl;

  String get markdownData;
  Timestamp get createdAt;

  Icon get icon;

  Map<String, dynamic> toJson();
}