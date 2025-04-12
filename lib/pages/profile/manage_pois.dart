import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/utils/constants.dart';

import '../../models/poi.dart';
import '../../providers/poi.dart';

class ManagePois extends ConsumerWidget {
  const ManagePois({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(kDefaultPadding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Text('This is a fullscreen dialog.'),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
              ElevatedButton(
                onPressed: () => ref.read(poiProvider.notifier).exportPois(),
                child: const Text('Export POIs'),
              ),
              ElevatedButton(onPressed: () => AddNextPoi(), child: const Text('Add next')),
            ],
          ),
        ],
      ),
    );
  }

  // TODO Remove
  void AddNextPoi() {
    final newPoi = Poi(
      id: 'to be changed',
      title: 'Kaple sv. Peregrina',
      imgUrl: 'https://www.orechovubrna.cz/data/kategorie/545_658_galerie.jpg',
      creationDate: Timestamp.now(),
      flags: {PoiFlags.monument, PoiFlags.food},
      location: GeoPoint(49.1118439, 16.5184100),
      markdownData: """## Kaple sv. Peregrina
    ![Kaplicka](https://www.orechovubrna.cz/data/kategorie/545_658_galerie.jpg)
    Kaple se nachází na kopci mezi obcemi Ořechov, Nebovidy a Želešice. Místo, kde kaple stojí, sehrálo důležitou úlohu při měření tzv. vídeňského poledníku v roce 1759, kdy byla jedním z pomocných trigonometrických bodů (smyslem měření bylo určení tvaru a velikosti Země). V roce 1863 zde byla vybudována zděná kaple, zasvěcená sv. Peregrinovi a váže se k ní stoletá tradice pěších poutí z Brna a okolí do Mariazell. Kaple byla první zastávkou na cestě, kde poutníci před obrazem Matky Boží a sv. Peregrina prosili o Boží pomoc a šťastný návrat domů.

    Tradice poutí je stále živá. Poutě byly v historii přerušeny v době válek a také v době komunistické vlády. Ale i tehdy se poutníci potají scházeli nadále, aby se u kapličky alespoň pomodlili.

    Každým rokem v květnu se koná pěší pouť ke kapličce, kde se farníci z blízkého okolí schází ke společné bohoslužbě. Je to jediná pouť ke cti sv. Peregrina, patrona při bolestech nohou a nemocech rakoviny, která se v naší zemi koná pravidelně.

        Ke kapli však zavítají poutníci i během celého roku, svědčí o tom vzkazy a svěřené úmysly modliteb, srdečné pozdravy a zapálené svíčky.
        """,
    );

    PoiProvider.persistPoi(newPoi);
  }
}
