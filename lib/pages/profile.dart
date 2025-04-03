import 'package:async_button_handler/async_button_handler.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/providers/auth_user.dart';

import '../services/auth_service.dart';

class ProfilePage extends ConsumerWidget {
  static const route = "/profile";

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile Page"),
          _buildSignInOutButton(ref),
        ],
      ),
    );
  }

  AsyncButtonHandler _buildSignInOutButton(WidgetRef ref) {
    final user = ref.watch(authUserProvider);
    final isSignedIn = user != null;

    return AsyncButtonHandler(
      onPressed: () async => isSignedIn ? await AuthService.signOut() : await AuthService.signInWithGoogle(),
      loadingChild: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CircularProgressIndicator(),
      ),
      widget: isSignedIn ? Text("profile.sign-out").tr() : Text("profile.sign-in").tr(),
    );
  }
}
