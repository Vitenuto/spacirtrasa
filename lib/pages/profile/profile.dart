import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/finished_trail.dart';
import 'package:spacirtrasa/models/map_entity.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/models/poi.dart';
import 'package:spacirtrasa/models/trail.dart';
import 'package:spacirtrasa/pages/profile/favorite_tile.dart';
import 'package:spacirtrasa/pages/profile/finished_trail_tile.dart';
import 'package:spacirtrasa/pages/profile/list_screen.dart';
import 'package:spacirtrasa/providers/app_user.dart';
import 'package:spacirtrasa/providers/auth_user.dart';
import 'package:spacirtrasa/providers/map_entity/favorite_map_entity.dart';
import 'package:spacirtrasa/providers/map_entity/finished_trails.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/trail.dart';
import 'package:spacirtrasa/providers/note.dart';
import 'package:spacirtrasa/services/auth.dart';
import 'package:spacirtrasa/services/map_entity/poi.dart';
import 'package:spacirtrasa/services/map_entity/trail.dart';
import 'package:spacirtrasa/widgets/async_button_handler.dart';

import 'manage_entities.dart';
import 'note_tile.dart';

class ProfilePage extends ConsumerWidget {
  static const route = "/profile";

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_buildProfileHeader(ref), _buildButtons(context, ref)],
      ),
    );
  }

  Widget _buildProfileHeader(final WidgetRef ref) {
    final user = ref.watch(authUserProvider);

    return IntrinsicWidth(
      child: Column(
        children: [
          user == null
              ? SizedBox()
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Colors.grey[300], // Placeholder background
                    backgroundImage: user.photoURL != null ? NetworkImage(user.photoURL!) : null,
                    child: user.photoURL == null ? Icon(Icons.person, size: 40, color: Colors.white) : null,
                  ),
                  SizedBox(height: 8),
                  Text(user.displayName ?? user.email ?? user.uid, style: TextStyle(fontSize: 24)),
                ],
              ),
          SizedBox(height: 8),
          _buildSignInOutButton(user != null),
        ],
      ),
    );
  }

  OutlinedAsyncButton _buildSignInOutButton(final bool isSignedIn) {
    return OutlinedAsyncButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
      onPressed: () async => isSignedIn ? await AuthService.signOut() : await AuthService.signInWithGoogle(),
      child: isSignedIn ? Text("profile.sign-out").tr() : Text("profile.sign-in").tr(),
    );
  }

  Widget _buildButtons(final BuildContext context, final WidgetRef ref) {
    final user = ref.watch(appUserProvider);
    if (user == null) return SizedBox();

    return IntrinsicWidth(
      child: Column(
        spacing: 8,
        children: [
          SizedBox(width: 256),
          _bodyButton("profile.my-favorites".tr(), () => _showFullDialog(context, ListScreen<MapEntity>(
            title: "profile.my-favorites".tr(),
            provider: favoriteMapEntityProvider,
            itemBuilder: (context, mapEntity) => FavoriteTile(mapEntity: mapEntity),
          ))),
          _bodyButton("profile.my-notes".tr(), () => _showFullDialog(context, ListScreen<Note>(
            title: "profile.my-notes".tr(),
            provider: noteProvider,
            itemBuilder: (context, note) => NoteTile(note: note, ref: ref),
          ))),
          _bodyButton("profile.my-completed-paths".tr(), () => _showFullDialog(context, ListScreen<FinishedTrail>(
            title: "profile.my-completed-paths".tr(),
            provider: finishedTrailsProvider,
            itemBuilder: (context, finishedTrail) => FinishedTrailTile(finishedTrail: finishedTrail, ref: ref),
          ))),
          if (user.isAdmin) ...[
            Text("profile.admin-section".tr(), style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),

            _bodyButton(
              "profile.manage-poi".tr(),
              () => _showFullDialog(context, ManageEntities<Poi>(PoiService(), poiProvider)),
            ),
            _bodyButton(
              "profile.manage-paths".tr(),
              () => _showFullDialog(context, ManageEntities<Trail>(TrailService(), trailProvider)),
            ),
          ],
        ],
      ),
    );
  }

  Future<String?> _showFullDialog(BuildContext context, final Widget child) {
    return showDialog<String>(context: context, builder: (BuildContext context) => Dialog.fullscreen(child: child));
  }

  OutlinedButton _bodyButton(final String text, final VoidCallback onPressed) => OutlinedButton(
    style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 42)),
    onPressed: onPressed,
    child: Text(text),
  );
}
