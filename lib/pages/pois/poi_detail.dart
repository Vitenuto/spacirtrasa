import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/models/app_user.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/pages/pois/main.dart';
import 'package:spacirtrasa/providers/app_user.dart';
import 'package:spacirtrasa/providers/expanded.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/services/router.dart';
import 'package:spacirtrasa/utils/utils.dart';
import 'package:spacirtrasa/widgets/editable_note_field.dart';

class PoiDetail extends ConsumerWidget {
  final Poi poi;

  const PoiDetail(this.poi, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appUser = ref.watch(appUserProvider);

    return Scaffold(
      appBar: AppBar(title: Text(poi.title), actions: _buildAppBarActions(appUser, ref, context)),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage.assetNetwork(
              placeholder: Assets.images.poiPlaceholder.keyName,
              image: poi.imgUrl,
            ),
          ),
          const SizedBox(height: 8),
          MarkdownBody(data: poi.markdownData),
          if (appUser != null) _buildEditableNoteField(ref, appUser),
        ],
      ),
    );
  }

  List<Widget> _buildAppBarActions(AppUser? appUser, WidgetRef ref, BuildContext context) => [
    IconButton(
      icon: const Icon(Icons.map),
      tooltip: 'poi-detail.show-on-map'.tr(),
      onPressed: () {
        ref.read(selectedPoiProvider.notifier).setSelected(poi);
        ref.read(expandedProvider.notifier).setExpanded(false);
        Navigator.of(context, rootNavigator: true).popUntil((route) => route.isFirst);
        RouteService.router.go(PoisPage.route);
      },
    ),
    if (appUser?.favoritePoiIds.contains(poi.id) != null)
      IconButton(
        icon: Icon(
          Icons.favorite,
          color: appUser!.favoritePoiIds.contains(poi.id) ? Colors.red : Colors.grey,
        ),
        tooltip: "${appUser.favoritePoiIds.contains(poi.id) ? 'remove' : 'add'}-favorite".tr(),
        onPressed: () => ref.read(appUserProvider.notifier).setFavoritePoi(poi.id),
      ),
  ];

  Widget _buildEditableNoteField(WidgetRef ref, AppUser appUser) {
    final note = appUser.notes.firstWhere(
      (note) => note.mapEntityId == poi.id,
      orElse: () => Note(mapEntityId: poi.id, text: '', type: MapEntityType.poi),
    );

    return EditableNoteField(note);
  }
}

void showPoiDetail(BuildContext context, Poi poi) => showFullDialog(context, PoiDetail(poi));