import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/poi.dart';
import '../utils/converters.dart';

part 'generated/poi.g.dart';

@riverpod
class PoiProvider extends _$PoiProvider {
  static final log = Logger();
  static const poisCollectionId = 'POIS';
  static final _firestore = FirebaseFirestore.instance;

  static final _poiCollection = _firestore
      .collection(poisCollectionId)
      .withConverter(
        fromFirestore: FirestoreConverters.fromFirestore<Poi>(Poi.fromJson),
        toFirestore: FirestoreConverters.toFirestore(),
      );

  @override
  List<Poi> build() {
    log.t("Building POI provider...");
    final poiSubscription = _poiCollection
        .snapshots()
        .map((poiSnapshot) => poiSnapshot.docs.map((poiDoc) => poiDoc.data()).toList())
        .listen(poiListener);
    ref.onDispose(() => poiSubscription.cancel());
    return List.empty();
  }

  void poiListener(pois) {
    log.t("POIs were updated: $pois");
    state = pois;
  }

  static Future<Poi> persistPoi(final Poi poi) async {
    final docRef = await _poiCollection.add(poi);
    final newPoi = poi.copyWith(id: docRef.id);
    log.i("New Poi was created: $newPoi");
    return newPoi;
  }

  static Future<void> removePoi(final Poi poi) async {
    await _poiCollection.doc(poi.id).delete();

    Fluttertoast.showToast(msg: "${poi} was successfully deleted");
  }

  Future<void> exportPois() async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      // User canceled the picker
      log.w("User canceled the folder picking, no export is done");
      return;
    }

    List<Poi> pois = state;
    if (pois.isEmpty) {
      pois = (await _poiCollection.get()).docs.map((poiDoc) => poiDoc.data()).toList();
      if (pois.isEmpty) {
        Fluttertoast.showToast(msg: "No POIs to export");
        return;
      }
    }
    final List<Map<String, dynamic>> jsonList = pois.map((poi) => poi.toJson()).toList();
    // Encode as pretty-printed JSON string
    final String jsonString = const JsonEncoder.withIndent('  ').convert(jsonList);
    final dateTimeString = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
    final File file = File('$selectedDirectory/pois_export_$dateTimeString.json');
    await file.writeAsString(jsonString);

    Fluttertoast.showToast(
      msg: "${pois.length} POIs are successfully exported to $selectedDirectory",
    );
  }
}
