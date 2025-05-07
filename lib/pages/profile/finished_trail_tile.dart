import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/trail/finished_trail.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';

class FinishedTrailTile extends ListTile {
  final FinishedTrail finishedTrail;
  final WidgetRef ref;

  const FinishedTrailTile({super.key, required this.finishedTrail, required this.ref});

  @override
  ListTile build(BuildContext context) {
    Trail? trail;
    final trails = ref.watch(trailProvider);
    trail = trails
        .where((trail) => trail.id == finishedTrail.trailId)
        .firstOrNull;

    return ListTile(
      title: Text(trail?.title ?? "Object does not exists anymore"),
      subtitle: Text(finishedTrail.finishedAt.toDate().toString()),
      // onTap: () => , TODO: open details page
    );
  }
}
