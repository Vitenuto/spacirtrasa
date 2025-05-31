import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flag.dart';

import 'map_entity.dart';

class PoiService extends MapEntityService<Poi> {
  static const poisCollectionId = 'POIS';

  PoiService() : super(poisCollectionId, Poi.fromJson);

  @override
  Future<void> addDummy() async {
    final newPoi = Poi(
      id: 'WillBeReplacedByUniqueOneAutomatically',
      title: 'DummyPoi',
      imgUrl: 'https://i.pinimg.com/736x/1b/fc/e9/1bfce97a85aecdd0c0a0cd48348c15ef.jpg',
      createdAt: Timestamp.now(),
      flag: PoiFlag.food,
      location: GeoPoint(49.1118439, 16.5184100),
      markdownData: """## Dummy Poi
    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&s)
    Jedná se o zkušební Poi pro ukázku aplikace. Je možné si ho nechat vyexportovat a tak vidět jeho JSON podobu. 
    
    ```json
    [
      {
        "id": "sFs04Nq9SCBeK2iwsafQ",
        "title": "DummyPoi",
        "imgUrl": "https://i.pinimg.com/736x/1b/fc/e9/1bfce97a85aecdd0c0a0cd48348c15ef.jpg",
        "markdownData": "## Dummy Poi\n    ![Kočka](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRWsPgWByMU--c3_sMuzFpY3be_4E6SiLFk8w&s)\n    Jedná se o zkušební Poi pro ukázku aplikace. Je možné si ho nechat vyexportovat a tak vidět jeho JSON podobu. \n    ",
        "location": {
          "lat": 49.1118439,
          "lng": 16.51841
        },
        "flag": "food",
        "creation_date": 1744970090831
      }
    ]
    ```
    """,
    );

    await persistEntity(newPoi);
  }
}
