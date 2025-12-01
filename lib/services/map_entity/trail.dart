import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gpx/gpx.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_flag.dart';
import 'package:spacirtrasa/services/map_entity/map_entity.dart';
import 'package:spacirtrasa/utils/utils.dart';

class TrailService extends MapEntityService<Trail> {
  static const trailsCollectionId = 'TRAILS';

  TrailService() : super(trailsCollectionId, Trail.fromJson);

  @override
  Future<void> addDummy() async {
    final newTrail = Trail(
      id: 'WillBeReplacedByUniqueOneAutomatically',
      title: {"cs": 'DummyTrail - CZ', "en": 'Dummy Trail - EN'},
      createdAt: Timestamp.now(),
      flag: TrailFlag.tourist,
      path: [
        GeoPoint(49.11266, 16.517277),
        GeoPoint(49.112675, 16.517288),
        GeoPoint(49.112801, 16.517348),
      ],
      markdownData: {
        "cs": """## Dummy Trail CZ
    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&s)
    Jedná se o zkušební stezku pro ukázku aplikace.
    Stezku lze naimportovat ať za pomocí JSON formátu, a nebo pomocí GPX formátu, který lze získat např. v aplikaci www.gpx.studio
    Značky lze specifikovat přidáním do hranatých závorek na první řádek popisu stezky. Dostupné značky jsou: [stroller, tourist, hill]
   """,
        "en": """## Dummy Trail EN
    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&s)
    Jedná se o zkušební stezku pro ukázku aplikace.
    Stezku lze naimportovat ať za pomocí JSON formátu, a nebo pomocí GPX formátu, který lze získat např. v aplikaci www.gpx.studio
    Značky lze specifikovat přidáním do hranatých závorek na první řádek popisu stezky. Dostupné značky jsou: [stroller, tourist, hill]
   """,
      },
    );

    await persistEntity(newTrail);
  }

  @override
  Future<int> importEntities() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      logger.w("User canceled the folder picking, no export is done");
      return 0;
    }

    var fileExtension = result.files.single.extension;
    if (fileExtension != 'json' && fileExtension != 'gpx') {
      Fluttertoast.showToast(
        msg: 'services.map_entity.map_entity_service.import-failed.unsupported-file'.tr(),
      );
      logger.w("Unsupported file type for import: $fileExtension");
      return 0;
    }
    if (fileExtension == 'json') {
      logger.i("User selected a JSON file for import");
      return super.importEntitiesFromJsonFile(result);
    }

    // Handle .gpx file
    final Trail trail;
    try {
      trail = await _decodeTrail(File(result.files.single.path!));
      await _validateTrail(trail);
      await persistEntity(trail);
    } on FormatException catch (e) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: 'services.map_entity.map_entity_service.import-failed.$Trail'.tr(args: [e.message]),
      );
      logger.e("FormatException during $Trail import", error: e);
      return 0;
    } catch (e, stack) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: 'services.map_entity.map_entity_service.import-failed-general.$Trail'.tr(),
      );
      logger.e("Error during $Trail import", error: e, stackTrace: stack);
      return 0;
    }

    logger.i("$Trail is successfully imported");
    return 1;
  }

  Future<Trail> _decodeTrail(File file) async {
    final String gpxContent = await file.readAsString();

    final gpxReader = GpxReader();
    final gpx = gpxReader.fromString(gpxContent);
    final geoPoints =
        gpx.trks.first.trksegs.first.trkpts
            .map((trkpt) => GeoPoint(trkpt.lat!, trkpt.lon!))
            .toList();

    final createdAt = gpx.metadata?.time ?? DateTime.now();
    final (flag, markdownData) = _parseFlagAndDescription(gpx.metadata?.desc);
    return Trail(
      id: "",
      title: {"cs": gpx.metadata!.name!},
      createdAt: Timestamp.fromDate(createdAt),
      markdownData: {"cs": markdownData},
      flag: flag,
      path: geoPoints,
    );
  }

  Future<void> _validateTrail(Trail trailToValidate) async {
    final currentTrails = await getEntities();

    if (currentTrails.any((existingEntity) => existingEntity.title == trailToValidate.title)) {
      throw FormatException("$Trail with title: '${trailToValidate.title}' already exists");
    }
  }

  (TrailFlag, String) _parseFlagAndDescription(String? data) {
    if (data == null) throw FormatException("Data is null");
    final regex = RegExp(r'^\[([^\]]+)\](.*)');
    final match = regex.firstMatch(data);

    if (match == null) throw FormatException("No flags found in the description");

    final flagRaw = match.group(1)!;
    final flag = TrailFlag.values.firstWhere((f) => f.name == flagRaw.trim());

    final description = match.group(2)!.trim();
    return (flag, description);
  }
}
