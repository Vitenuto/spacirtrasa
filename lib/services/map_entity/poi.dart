import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flag.dart';
import 'package:spacirtrasa/services/map_entity/map_entity.dart';

class PoiService extends MapEntityService<Poi> {
  static const poisCollectionId = 'POIS';

  PoiService() : super(poisCollectionId, Poi.fromJson);

  @override
  Future<void> addDummy() async {
    final newPoi = Poi(
      id: 'WillBeReplacedByUniqueOneAutomatically',
      title: {"cs": 'DummyPoi - CZ', "en": 'DummyPoi - EN'},
      imgUrl: 'https://i.pinimg.com/736x/1b/fc/e9/1bfce97a85aecdd0c0a0cd48348c15ef.jpg',
      createdAt: Timestamp.now(),
      flag: PoiFlag.food,
      location: GeoPoint(49.1118439, 16.5184100),
      markdownData: {
        "cs": """## Dummy Poi CZ
    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&s)
    Jedná se o zkušební Poi pro ukázku aplikace.""",
        "en": """## Dummy Poi CZ
    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&s)
    Jedná se o zkušební Poi pro ukázku aplikace.""",
      },
    );

    await persistEntity(newPoi);
  }
}
