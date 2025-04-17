import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';

import '../models/poi.dart';
import '../utils/converters.dart';

class PoiService {
  static final log = Logger();
  static const poisCollectionId = 'POIS';
  static final _firestore = FirebaseFirestore.instance;

  static final poiCollection = _firestore
      .collection(poisCollectionId)
      .withConverter(
        fromFirestore: FirestoreConverters.fromFirestore<Poi>(Poi.fromJson),
        toFirestore: FirestoreConverters.toFirestore(),
      );

  static Future<List<Poi>> getPois() async {
    final pois = await poiCollection.get();
    return pois.docs.map((poiDoc) => poiDoc.data()).toList();
  }

  static Future<Poi> persistPoi(final Poi poi) async {
    final docRef = await poiCollection.add(poi);
    final newPoi = poi.copyWith(id: docRef.id);
    log.i("New Poi was created: $newPoi");
    return newPoi;
  }

  static Future<void> removePoi(final String poiId) async {
    await poiCollection.doc(poiId).delete();

    Fluttertoast.showToast(msg: "POI with id: ${poiId} was successfully deleted");
  }

  static Future<void> exportPois(List<Poi> pois) async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      log.w("User canceled the folder picking, no export is done");
      return;
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

  static Future<void> importPois() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      log.w("User canceled the folder picking, no export is done");
      return;
    }

    final List<Poi> pois;
    try {
      pois = await _decodePois(File(result.files.single.path!));
      await _validatePois(pois);
      await Future.wait(pois.map(persistPoi));
    } on FormatException catch (e) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: "Importing of POIs failed with: ${e.message}",
      );
      log.e("FormatException during POI import", error: e);
      return;
    } catch (e, stack) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: "Failed to import POIs, discuss with administrator",
      );
      log.e("Error during POI import", error: e, stackTrace: stack);
      return;
    }
    Fluttertoast.showToast(msg: "${pois.length} POIs are successfully imported");
  }

  static Future<List<Poi>> _decodePois(File file) async {
    final String content = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(content);

    // Validate the structure
    if (jsonList is! List) throw FormatException("The file does not contain a JSON list.");

    final importedPois =
        jsonList.map((item) {
          if (item is! Map<String, dynamic>) {
            throw FormatException("Invalid item format, failing item: $item");
          }
          return Poi.fromJson(item);
        }).toList();

    return importedPois;
  }

  static Future<void> _validatePois(List<Poi> poisToValidate) async {
    final currentPois = await getPois();

    for (final poiToValidate in poisToValidate) {
      if (currentPois.any((existingPoi) => existingPoi.title == poiToValidate.title)) {
        throw FormatException("POI with title: '${poiToValidate.title}' already exists");
      }
    }
  }
}
