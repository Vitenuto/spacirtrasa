import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/utils/converters.dart';

abstract class MapEntityService<T extends MapEntity> {
  final log = Logger();
  final _firestore = FirebaseFirestore.instance;
  final String entityCollectionId;
  final T Function(Map<String, dynamic>) fromJson;

  late final CollectionReference<T> entityCollection;
  late final Stream<List<T>> entityCollectionStream;

  MapEntityService(this.entityCollectionId, this.fromJson) {
    entityCollection = _firestore
        .collection(entityCollectionId)
        .withConverter(
          fromFirestore: FirestoreConverters.fromFirestore<T>(fromJson),
          toFirestore: FirestoreConverters.toFirestore(),
        );

    entityCollectionStream = entityCollection.snapshots().map(
          (entitySnapshot) => entitySnapshot.docs.map((entityDoc) => entityDoc.data()).toList(),
    );
  }

  Future<List<T>> getEntities() async {
    final entities = await entityCollection.get();
    return entities.docs.map((eDoc) => eDoc.data()).toList();
  }

  Future<T?> persistEntity(final T entity) async {
    var newEntity = (await (await entityCollection.add(entity)).get()).data();
    if (newEntity == null) log.e("Failed to persist $entity to the database");
    log.i("New $T was created: $newEntity");
    return newEntity;
  }

  Future<void> addDummy();

  Future<void> removeEntity(final T entity) async {
    await entityCollection.doc(entity.id).delete();
    log.i("Removed $entity from the database");
  }

  Future<void> removeEntities(final List<T> entities) async {
    await Future.wait(entities.map(removeEntity));
    log.i("Removed ${entities.length} ${T}s from the database");
  }

  Future<String?> exportEntities(List<MapEntity> entities) async {
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    if (selectedDirectory == null) {
      log.w("User canceled the folder picking, no export is done");
      return null;
    }

    final List<Map<String, dynamic>> jsonList = entities.map((entity) => entity.toJson()).toList();
    // Encode as pretty-printed JSON string
    final String jsonString = const JsonEncoder.withIndent('  ').convert(jsonList);
    final dateTimeString = DateFormat('yyyy-MM-dd_HH-mm-ss').format(DateTime.now());
    final File file = File('$selectedDirectory/${T}s_export_$dateTimeString.json');
    await file.writeAsString(jsonString);

    log.i("Exported ${entities.length} ${T}s to $selectedDirectory");
    return selectedDirectory;
  }

  Future<int> importEntities() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      log.w("User canceled the file picking, no import is done");
      return 0;
    }

    return await importEntitiesFromJsonFile(result);
  }

  Future<int> importEntitiesFromJsonFile(FilePickerResult result) async {
    final List<T> entities;
    try {
      entities = await _decodeEntity(File(result.files.single.path!));
      await _validateEntities(entities);
      await Future.wait(entities.map(persistEntity));
    } on FormatException catch (e) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: 'services.map_entity.map_entity_service.import-failed.$T'.tr(args: [e.message]),
      );
      log.e("FormatException during $T import", error: e);
      return 0;
    } catch (e, stack) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: 'services.map_entity.map_entity_service.import-failed-general.$T'.tr(),
      );
      log.e("Error during $T import", error: e, stackTrace: stack);
      return 0;
    }

    log.i("${entities.length} ${T}s are successfully imported");
    return entities.length;
  }

  Future<List<T>> _decodeEntity(File file) async {
    final String content = await file.readAsString();
    final List<dynamic> jsonList = jsonDecode(content);

    final importedEntities =
        jsonList.map((item) {
          if (item is! Map<String, dynamic>) {
            throw FormatException("Invalid item format, failing item: $item");
          }
          return fromJson(item);
        }).toList();

    return importedEntities;
  }

  Future<void> _validateEntities(List<T> entitiesToValidate) async {
    final currentEntities = await getEntities();

    for (final entityToValidate in entitiesToValidate) {
      if (currentEntities.any((existingEntity) => existingEntity.title == entityToValidate.title)) {
        throw FormatException("$T with title: '${entityToValidate.title}' already exists");
      }
    }
  }
}
