import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gpx/gpx.dart';
import 'package:spacirtrasa/models/trail.dart';
import 'package:spacirtrasa/models/trail_flags.dart';

import 'map_entity.dart';

class TrailService extends MapEntityService<Trail> {
  static const trailsCollectionId = 'TRAILS';

  TrailService() : super(trailsCollectionId, Trail.fromJson);

  @override
  Future<void> addDummy() async {
    final newTrail = Trail(
      id: 'WillBeReplacedByUniqueOneAutomatically',
      title: 'DummyTrail',
      createdAt: Timestamp.now(),
      flags: {TrailFlags.stroller, TrailFlags.tourist, TrailFlags.hill},
      path: [
        GeoPoint(49.11266, 16.517277),
        GeoPoint(49.112675, 16.517288),
        GeoPoint(49.112801, 16.517348),
      ],
      markdownData: """## Dummy Trail
    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&s)
    Jedná se o zkušební stezku pro ukázku aplikace. Je možné si ho nechat vyexportovat a tak vidět jeho JSON podobu.
    Stezku lze naimportovat ať za pomocí JSON formátu, a nebo pomocí GPX formátu, který lze získat např. v aplikaci www.gpx.studio
    Značky lze specifikovat přidáním do hranatých závorek na první řádek popisu stezky. Dostupné značky jsou: [stroller, tourist, hill]
    
    Takový GPX formát pak vypadá:
    ```gpx
    <?xml version="1.0" encoding="UTF-8"?>
      <gpx creator="https://gpx.studio" version="1.1" xmlns="http://www.topografix.com/GPX/1/1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd http://www.garmin.com/xmlschemas/GpxExtensions/v3 http://www.garmin.com/xmlschemas/GpxExtensionsv3.xsd http://www.garmin.com/xmlschemas/TrackPointExtension/v1 http://www.garmin.com/xmlschemas/TrackPointExtensionv1.xsd http://www.garmin.com/xmlschemas/PowerExtension/v1 http://www.garmin.com/xmlschemas/PowerExtensionv1.xsd http://www.topografix.com/GPX/gpx_style/0/2 http://www.topografix.com/GPX/gpx_style/0/2/gpx_style.xsd" xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1" xmlns:gpxx="http://www.garmin.com/xmlschemas/GpxExtensions/v3" xmlns:gpxpx="http://www.garmin.com/xmlschemas/PowerExtension/v1" xmlns:gpx_style="http://www.topografix.com/GPX/gpx_style/0/2">
      <metadata>
        <name>Cestička</name>
        <desc>[stroller, tourist, hill]Test of Markdown description
    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&amp;s)</desc>
        <author>
          <name>gpx.studio</name>
          <link href="https://gpx.studio"/>
        </author>
       </metadata>
      <trk>
        <name>Cestička</name>
        <trkseg>
          <trkpt lat="49.11266" lon="16.517277">
            <ele>303.75</ele>
          </trkpt>
          <trkpt lat="49.112675" lon="16.517288">
            <ele>304</ele>
          </trkpt>
          <trkpt lat="49.112801" lon="16.517348">
            <ele>304.5</ele>
          </trkpt>
          <trkpt lat="49.113332" lon="16.517732">
            <ele>306.25</ele>
          </trkpt>
          <trkpt lat="49.113472" lon="16.517877">
            <ele>305.75</ele>
          </trkpt>
          <trkpt lat="49.113891" lon="16.518487">
            <ele>304.75</ele>
          </trkpt>
          <trkpt lat="49.113827" lon="16.518648">
            <ele>304.5</ele>
          </trkpt>
          <trkpt lat="49.113926" lon="16.518919">
            <ele>304.5</ele>
          </trkpt>
          <trkpt lat="49.114203" lon="16.518824">
            <ele>305</ele>
          </trkpt>
          <trkpt lat="49.114482" lon="16.518854">
            <ele>305.5</ele>
          </trkpt>
          <trkpt lat="49.114897" lon="16.519002">
            <ele>306.5</ele>
          </trkpt>
          <trkpt lat="49.115001" lon="16.519069">
            <ele>306.75</ele>
          </trkpt>
          <trkpt lat="49.115032" lon="16.519119">
            <ele>307</ele>
          </trkpt>
          <trkpt lat="49.115033" lon="16.519182">
            <ele>307</ele>
          </trkpt>
          <trkpt lat="49.114801" lon="16.521112">
            <ele>306</ele>
          </trkpt>
          <trkpt lat="49.114807" lon="16.521117">
            <ele>306</ele>
          </trkpt>
          <trkpt lat="49.114801" lon="16.521112">
            <ele>306</ele>
          </trkpt>
          <trkpt lat="49.115033" lon="16.519182">
            <ele>307</ele>
          </trkpt>
          <trkpt lat="49.115032" lon="16.519119">
            <ele>307</ele>
          </trkpt>
          <trkpt lat="49.115001" lon="16.519069">
            <ele>306.75</ele>
          </trkpt>
          <trkpt lat="49.114897" lon="16.519002">
            <ele>306.5</ele>
          </trkpt>
          <trkpt lat="49.115258" lon="16.516227">
            <ele>307.75</ele>
          </trkpt>
          <trkpt lat="49.115802" lon="16.514028">
            <ele>311</ele>
          </trkpt>
          <trkpt lat="49.115813" lon="16.513986">
            <ele>311.25</ele>
          </trkpt>
          <trkpt lat="49.114303" lon="16.512633">
            <ele>315.75</ele>
          </trkpt>
          <trkpt lat="49.113681" lon="16.512073">
            <ele>316.5</ele>
          </trkpt>
          <trkpt lat="49.113619" lon="16.512142">
            <ele>316</ele>
          </trkpt>
          <trkpt lat="49.11359" lon="16.512176">
            <ele>316</ele>
          </trkpt>
          <trkpt lat="49.11264" lon="16.513988">
            <ele>311.5</ele>
          </trkpt>
          <trkpt lat="49.112526" lon="16.514205">
            <ele>310.75</ele>
          </trkpt>
          <trkpt lat="49.112402" lon="16.514437">
            <ele>309.75</ele>
          </trkpt>
          <trkpt lat="49.111586" lon="16.515954">
            <ele>303.75</ele>
          </trkpt>
          <trkpt lat="49.111519" lon="16.516051">
            <ele>302.75</ele>
          </trkpt>
          <trkpt lat="49.111446" lon="16.516157">
            <ele>301.75</ele>
          </trkpt>
          <trkpt lat="49.111288" lon="16.516451">
            <ele>299.5</ele>
          </trkpt>
          <trkpt lat="49.111224" lon="16.51637">
            <ele>299.5</ele>
          </trkpt>
          <trkpt lat="49.111288" lon="16.516451">
            <ele>299.5</ele>
          </trkpt>
          <trkpt lat="49.111446" lon="16.516157">
            <ele>301.75</ele>
          </trkpt>
          <trkpt lat="49.111458" lon="16.516285">
            <ele>301.25</ele>
          </trkpt>
          <trkpt lat="49.111497" lon="16.516329">
            <ele>301.25</ele>
          </trkpt>
          <trkpt lat="49.111607" lon="16.516433">
            <ele>301</ele>
          </trkpt>
          <trkpt lat="49.112301" lon="16.517038">
            <ele>302.5</ele>
          </trkpt>
          <trkpt lat="49.112658" lon="16.517277">
            <ele>304</ele>
          </trkpt>
        </trkseg>
      </trk>
    </gpx>
    ```
    
    JSON formát potom:
    ```json
    [
      {
        "id": "MmCM7dI7hHYiCe3MkLpd",
        "title": "DummyTrail",
        "markdownData": "## Dummy Trail\n    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&s)\n    Jedná se o zkušební Trail pro ukázku aplikace. Je možné si ho nechat vyexportovat a tak vidět jeho JSON podobu. \n    \n    ```json\n    TODO\n    ```\n    ",
        "path": [
          {
            "lat": 49.11266,
            "lng": 16.517277
          },
          {
            "lat": 49.112675,
            "lng": 16.517288
          },
          {
            "lat": 49.112801,
            "lng": 16.517348
          }
        ],
        "flags": [
          "stroller",
          "tourist",
          "hill"
        ],
        "created_at": 1745497455462
      }
    ]
    ```
    """,
    );

    await persistEntity(newTrail);
  }

  @override
  Future<int> importEntities() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result == null) {
      log.w("User canceled the folder picking, no export is done");
      return 0;
    }

    var fileExtension = result.files.single.extension;
    if (fileExtension != 'json' && fileExtension != 'gpx') {
      Fluttertoast.showToast(
        msg: 'services.map_entity.map_entity_service.import-failed.unsupported-file'.tr(),
      );
      log.w("Unsupported file type for import: $fileExtension");
      return 0;
    }
    if (fileExtension == 'json') {
      log.i("User selected a JSON file for import");
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
      log.e("FormatException during $Trail import", error: e);
      return 0;
    } catch (e, stack) {
      Fluttertoast.showToast(
        toastLength: Toast.LENGTH_LONG,
        msg: 'services.map_entity.map_entity_service.import-failed-general.$Trail'.tr(),
      );
      log.e("Error during $Trail import", error: e, stackTrace: stack);
      return 0;
    }

    log.i("$Trail is successfully imported");
    return 1;
  }

  Future<Trail> _decodeTrail(File file) async {
    final String gpxContent = await file.readAsString();

    final gpxReader = GpxReader();
    final gpx = gpxReader.fromString(gpxContent);
    final geoPoints = gpx.trks.first.trksegs.first.trkpts.map((trkpt) =>
        GeoPoint(trkpt.lat!, trkpt.lon!)).toList();

    final createdAt = gpx.metadata?.time ?? DateTime.now();
    final (flags, markdownData) = _parseFlagsAndDescription(gpx.metadata?.desc);
    return Trail(id: "",
        title: gpx.metadata!.name!,
        createdAt: Timestamp.fromDate(createdAt),
        markdownData: markdownData,
        flags: flags,
        path: geoPoints);
  }

  Future<void> _validateTrail(Trail trailToValidate) async {
    final currentTrails = await getEntities();

    if (currentTrails.any((existingEntity) => existingEntity.title == trailToValidate.title)) {
      throw FormatException("$Trail with title: '${trailToValidate.title}' already exists");
    }
  }

  (Set<TrailFlags>, String) _parseFlagsAndDescription(String? data) {
    if (data == null) return ({}, "");
    final regex = RegExp(r'^\[([^\]]+)\](.*)');
    final match = regex.firstMatch(data);

    if (match == null) return ({}, data);

    final flagsRaw = match.group(1)!;
    final flags = flagsRaw.split(',').map((flagString) =>
        TrailFlags.values.firstWhere((f) => f.name == flagString.trim())).toSet();

    final description = match.group(2)!.trim();
    return (flags, description);
  }
}
