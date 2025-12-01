import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/pages/pois/poi_detail.dart';
import 'package:spacirtrasa/pages/trails/trail_detail.dart';

class FavoriteTile extends ConsumerWidget {
  final MapEntity mapEntity;

  const FavoriteTile({super.key, required this.mapEntity});

  @override
  ListTile build(BuildContext context, WidgetRef ref) {
    late final VoidCallback openDetail;

    if (mapEntity is Poi) {
      openDetail = () => showPoiDetail(context, mapEntity as Poi);
    } else {
      openDetail = () => showTrailDetail(context, mapEntity as Trail);
    }

    return ListTile(
      leading:
          mapEntity.imgUrl != null
              ? ClipRRect(
                borderRadius: BorderRadius.circular(4.0),
                child: Image.network(mapEntity.imgUrl!),
              )
              : null,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(mapEntity.titleLocalized), mapEntity.icon],
      ),
      subtitle: Text(
        mapEntity.markdownLessDataLocalized,
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
      onTap: openDetail,
    );
  }
}
