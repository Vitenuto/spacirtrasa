import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';

class FirestoreConverters {
  static final log = Logger();

  static T Function(DocumentSnapshot<Map<String, dynamic>>, SnapshotOptions?) fromFirestore<T>(
    Function(Map<String, dynamic>) fromJson,
  ) {
    return (snapshot, _) {
      try {
        return fromJson({'id': snapshot.id, ...(snapshot.data() ?? {})});
      } catch (e) {
        log.e(
          "Unable to parse '$T' from firestore object having id: ${snapshot.id} and data: ${snapshot.data()}",
        );
        rethrow;
      }
    };
  }

  static Map<String, Object?> Function(dynamic, SetOptions?) toFirestore() {
    return (value, _) {
      final json = value.toJson();
      json.remove('id');

      return json;
    };
  }
}
