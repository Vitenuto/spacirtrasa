import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:spacirtrasa/models/map_entity/map_entity.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/trail/finished_trail.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/note.dart';
import 'package:spacirtrasa/pages/profile/favorite_tile.dart';
import 'package:spacirtrasa/pages/profile/finished_trail_tile.dart';
import 'package:spacirtrasa/pages/profile/list_screen.dart';
import 'package:spacirtrasa/pages/profile/manage_entities.dart';
import 'package:spacirtrasa/pages/profile/note_tile.dart';
import 'package:spacirtrasa/providers/map_entity/favorite_map_entity.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/trail/finished_trails.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';
import 'package:spacirtrasa/providers/note.dart';
import 'package:spacirtrasa/providers/user/app_user.dart';
import 'package:spacirtrasa/providers/user/firebase_user.dart';
import 'package:spacirtrasa/services/feedback.dart';
import 'package:spacirtrasa/services/map_entity/poi.dart';
import 'package:spacirtrasa/services/map_entity/trail.dart';
import 'package:spacirtrasa/utils/utils.dart';
import 'package:spacirtrasa/widgets/async_button_handler.dart';

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

  Widget _buildProfileHeader(WidgetRef ref) {
    final user = ref.watch(firebaseUserProvider);
    final firebaseUserService = ref.read(firebaseUserProvider.notifier);

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
                    child:
                        user.photoURL == null
                            ? Icon(Icons.person, size: 40, color: Colors.white)
                            : null,
                  ),
                  SizedBox(height: 8),
                  Text(user.displayName ?? user.email ?? user.uid, style: TextStyle(fontSize: 24)),
                ],
              ),
          SizedBox(height: 8),
          _buildSignInOutButton(user != null, firebaseUserService),
        ],
      ),
    );
  }

  OutlinedAsyncButton _buildSignInOutButton(
    bool isSignedIn,
    FirebaseUserProvider firebaseUserService,
  ) {
    return OutlinedAsyncButton(
      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
      onPressed:
          () async =>
              isSignedIn
                  ? firebaseUserService.handleSignOut()
                  : await firebaseUserService.handleSignIn(),
      child: isSignedIn ? Text("profile.sign-out").tr() : Text("profile.sign-in").tr(),
    );
  }

  Widget _buildButtons(BuildContext context, WidgetRef ref) {
    final user = ref.watch(appUserProvider);

    return IntrinsicWidth(
      child: Column(
        spacing: 8,
        children: [
          SizedBox(width: 256),
          _buildBodyButton(
            "profile.my-favorites".tr(),
            () => showFullDialog(
              context,
              ListScreen<MapEntity>(
                title: "profile.my-favorites".tr(),
                listEmptyInfo: "profile.no-favorites".tr(),
                provider: favoriteMapEntityProvider,
                itemBuilder: (context, mapEntity) => FavoriteTile(mapEntity: mapEntity),
              ),
            ),
          ),
          _buildBodyButton(
            "profile.my-notes".tr(),
            () => showFullDialog(
              context,
              ListScreen<Note>(
                title: "profile.my-notes".tr(),
                listEmptyInfo: "profile.no-notes".tr(),
                provider: noteProvider,
                itemBuilder: (context, note) => NoteTile(note: note),
              ),
            ),
          ),
          _buildBodyButton(
            "profile.my-completed-trails".tr(),
            () => showFullDialog(
              context,
              ListScreen<FinishedTrail>(
                title: "profile.my-completed-trails".tr(),
                listEmptyInfo: "profile.no-completed-trails".tr(),
                provider: finishedTrailsProvider,
                itemBuilder:
                    (context, finishedTrail) => FinishedTrailTile(finishedTrail: finishedTrail),
              ),
            ),
          ),
          if (user.isAdmin) ...[
            Text(
              "profile.admin-section".tr(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            _buildBodyButton(
              "profile.manage-poi".tr(),
              () => showFullDialog(context, ManageEntities<Poi>(PoiService(), poiProvider)),
            ),
            _buildBodyButton(
              "profile.manage-trails".tr(),
              () => showFullDialog(context, ManageEntities<Trail>(TrailService(), trailProvider)),
            ),
          ],
          Divider(),
          _buildBodyButton('profile.send-feedback'.tr(), () => _showFeedbackDialog(context)),
        ],
      ),
    );
  }

  OutlinedButton _buildBodyButton(String text, VoidCallback onPressed) => OutlinedButton(
    style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 42)),
    onPressed: onPressed,
    child: Text(text),
  );

  Future<void> _showFeedbackDialog(BuildContext context) async {
    final controller = TextEditingController();

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            content: TextField(
              controller: controller,
              maxLines: 5,
              decoration: InputDecoration(hintText: 'profile.send-feedback.hint'.tr()),
            ),
            actions: [
              TextButton(onPressed: () => Navigator.pop(context), child: const Text('cancel').tr()),
              TextButton(
                onPressed: () async {
                  final feedbackText = controller.text.trim();
                  if (feedbackText.isNotEmpty) {
                    await createFeedback(feedbackText);

                    if (!context.mounted) return;
                    Navigator.pop(context);
                    Fluttertoast.showToast(msg: 'profile.send-feedback.success'.tr());
                  }
                },
                child: const Text('send').tr(),
              ),
            ],
          ),
    );
  }
}
