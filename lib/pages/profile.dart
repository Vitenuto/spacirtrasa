import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

class ProfilePage extends StatelessWidget {
  static const route = "/profile";

  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profile Page"),
          ElevatedButton(
            onPressed: () async {
              await AuthService.signOut();
            },
            child: Text("profile.sign-out").tr(),
          ),
        ],
      ),
    );
  }
}
