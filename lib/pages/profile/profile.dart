import 'package:async_button_handler/async_button_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/pages/profile/manage_pois.dart';
import 'package:spacirtrasa/providers/auth_user.dart';

import '../../providers/app_user.dart';
import '../../services/auth_service.dart';
import '../../services/map_entity/poi_service.dart';

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
                backgroundImage:
                user.photoURL != null
                    ? NetworkImage(user.photoURL!) // Load image if available
                    : null, // No image if null
                child:
                user.photoURL == null
                    ? Icon(Icons.person, size: 40, color: Colors.white) // Default icon
                    : null,
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

  AsyncButtonHandler _buildSignInOutButton(final bool isSignedIn) {
    return AsyncButtonHandler(
      style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 48)),
      onPressed:
          () async =>
      isSignedIn ? await AuthService.signOut() : await AuthService.signInWithGoogle(),
      loadingChild: CircularProgressIndicator(),
      widget: isSignedIn ? Text("profile.sign-out").tr() : Text("profile.sign-in").tr(),
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
          bodyButton("profile.my-favorites".tr(), () => {}),
          bodyButton("profile.my-ratings".tr(), () => {}),
          bodyButton("profile.my-notes".tr(), () => {}),
          bodyButton("profile.my-completed-paths".tr(), () => {}),
          if (user.isAdmin) ...[
            const Text(
              "profile.admin-section",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ).tr(),

            bodyButton("profile.manage-poi".tr(), () => _showFullDialog(context, ManagePois(PoiService()))),
            bodyButton("profile.manage-paths".tr(), () => {}),
          ],
        ],
      ),
    );
  }

  Future<String?> _showFullDialog(BuildContext context, final Widget child) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => Dialog.fullscreen(child: child),
    );
  }

  OutlinedButton bodyButton(final String text, final VoidCallback onPressed) =>
      OutlinedButton(
        style: OutlinedButton.styleFrom(minimumSize: const Size(double.infinity, 42)),
        onPressed: onPressed,
        child: Text(text),
      );
}
