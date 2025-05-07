import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/pages/pois/poi_detail.dart';
import 'package:spacirtrasa/pages/trails/trail_detail.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';

class NoteTile extends ConsumerWidget {
  static final log = Logger();
  final Note note;

  const NoteTile({super.key, required this.note});

  @override
  ListTile build(BuildContext context, WidgetRef ref) {
    log.t("Building NoteTile for note: $note");
    String? title;
    VoidCallback? openDetail;
    Icon? icon;
    if (note.type == MapEntityType.poi) {
      final pois = ref.watch(poiProvider);
      final poi = pois.where((poi) => poi.id == note.mapEntityId).firstOrNull;
      title = poi?.title;
      if (poi != null) {
        openDetail = () => showPoiDetail(context, poi);
        icon = poi.icon;
      }
    } else {
      final trails = ref.watch(trailProvider);
      log.i("Trails: $trails");
      final trail = trails.where((trail) => trail.id == note.mapEntityId).firstOrNull;
      title = trail?.title;
      if (trail != null) {
        openDetail = () => showTrailDetail(context, trail);
        icon = trail.icon;
      }
    }

    return ListTile(
      style: ListTileStyle.list,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title ?? "Object does not exists anymore"), if (icon != null) icon],
      ),
      subtitle: Text(note.text),
      onTap: openDetail,
    );
  }
}
