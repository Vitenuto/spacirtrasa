import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const supplementariesCollectionId = 'SUPPLEMENTARIES';
final _firestore = FirebaseFirestore.instance;

final _supplementariesCollection = _firestore.collection(supplementariesCollectionId);

Stream<String> getHomeTextStream() {
  return _supplementariesCollection.doc('home_text').snapshots().map((docSnapshot) => docSnapshot.data()?['text'] as String? ?? '');
}

Stream<String> getAboutVillageTextStream() {
  return _supplementariesCollection.doc('about_village_text').snapshots().map((docSnapshot) => docSnapshot.data()?['text'] as String? ?? '');
}

final homeTextProvider = StreamProvider<String>((_) => getHomeTextStream());

final aboutVillageTextProvider = StreamProvider<String>((_) => getAboutVillageTextStream());
