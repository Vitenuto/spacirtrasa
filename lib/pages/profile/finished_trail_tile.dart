import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/trail/finished_trail.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/pages/trails/trail_detail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';

class FinishedTrailTile extends ConsumerWidget {
  final FinishedTrail finishedTrail;

  const FinishedTrailTile({super.key, required this.finishedTrail});

  @override
  ListTile build(BuildContext context, WidgetRef ref) {
    Trail? trail;
    final trails = ref.watch(trailProvider);
    trail = trails.where((trail) => trail.id == finishedTrail.trailId).firstOrNull;

    return ListTile(
      title: Text(trail?.title ?? "Object does not exists anymore"),
      subtitle: Text(finishedTrail.finishedAt.toDate().toString()),
      onTap: trail != null ? () => showTrailDetail(context, trail!) : null,
    );
  }
}
