import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MapEntity {
  String get id;
  String get title;
  Timestamp get createdAt;

  Map<String, dynamic> toJson();
}