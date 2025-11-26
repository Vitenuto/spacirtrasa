import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const supplementariesCollectionId = 'SUPPLEMENTARIES';
final _firestore = FirebaseFirestore.instance;

final _supplementariesCollection = _firestore.collection(supplementariesCollectionId);

Stream<String> getHomeTextStream(String languageCode) {
  return _supplementariesCollection
      .doc('home_text')
      .snapshots()
      .map((docSnapshot) => docSnapshot.data()?[languageCode] as String? ?? '');
}

Stream<String> getAboutVillageTextStream(String languageCode) {
  return _supplementariesCollection
      .doc('about_village_text')
      .snapshots()
      .map((docSnapshot) => docSnapshot.data()?[languageCode] as String? ?? '');
}

final homeTextProvider = StreamProvider.family<String, String>(
  (_, languageCode) => getHomeTextStream(languageCode),
);

final aboutVillageTextProvider = StreamProvider.family<String, String>(
  (_, languageCode) => getAboutVillageTextStream(languageCode),
);
