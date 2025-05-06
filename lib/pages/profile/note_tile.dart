import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';

class NoteTile extends ListTile {
  final Note note;
  final WidgetRef ref;

  const NoteTile({super.key, required this.note, required this.ref});

  @override
  ListTile build(BuildContext context) {
    MapEntity? mapEntity;
    if (note.type == MapEntityType.poi) {
      final pois = ref.watch(poiProvider);
      mapEntity = pois.where((poi) => poi.id == note.mapEntityId).firstOrNull;
    } else {
      final trails = ref.watch(trailProvider);
      mapEntity = trails.where((trail) => trail.id == note.mapEntityId).firstOrNull;
    }

    return ListTile(
      style: ListTileStyle.list,
      title: Text(mapEntity?.title ?? "Object does not exists anymore"),
      subtitle: Text(note.text),
      // onTap: () => , TODO: open details page
    );
  }
}
