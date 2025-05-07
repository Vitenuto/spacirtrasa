import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/providers/app_user.dart';
import 'package:spacirtrasa/providers/expanded.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/utils/utils.dart';
import 'package:spacirtrasa/widgets/editable_note_field.dart';

class TrailDetail extends ConsumerWidget {
  final Trail trail;

  const TrailDetail(this.trail, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text(trail.title), actions: _buildAppBarActions(appUser, ref, context)),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          MarkdownBody(data: trail.markdownData),
          if (appUser != null) _buildEditableNoteField(ref, appUser),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarActions(AppUser? appUser, WidgetRef ref, BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.map),
      tooltip: 'Zobrazit na mapě',
      onPressed: () {
        ref.read(pinnedTrailProvider.notifier).setPinned(trail);
        ref.read(selectedTrailProvider.notifier).setSelected(trail);
        ref.read(expandedProvider.notifier).setExpanded(false);
        Navigator.of(context, rootNavigator: true).pop();
      },
    ),
    if (appUser?.favoriteTrailIds.contains(trail.id) != null)
      IconButton(
        icon: Icon(
          Icons.favorite,
          color: appUser!.favoriteTrailIds.contains(trail.id) ? Colors.red : Colors.grey,
        ),
        tooltip: "${appUser.favoriteTrailIds.contains(trail.id) ? 'Odebrat' : 'Přidat'} k oblíbeným",
        onPressed: () {
          ref.read(appUserProvider.notifier).setFavoriteTrail(trail.id);
        },
      ),
  ];

  Widget _buildEditableNoteField(WidgetRef ref, AppUser appUser) {
    final note = appUser.notes.firstWhere(
      (note) => note.mapEntityId == trail.id,
      orElse: () => Note(mapEntityId: trail.id, text: '', type: MapEntityType.trail),
    );

    return EditableNoteField(note);
  }
}

void showTrailDetail(BuildContext context, Trail trail) => showFullDialog(context, TrailDetail(trail));