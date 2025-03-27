import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:spacirtrasa/services/auth_service.dart';

import '../generated/assets.gen.dart';

class LoginPage extends StatelessWidget {
  static const route = "/login";

  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.logo.image(width: 350, height: 350, fit: BoxFit.scaleDown),
            const SizedBox(height: 48.0),
            _buildSignInButtons(context),
          ],
        ),
      ),
    );
  }

  IntrinsicWidth _buildSignInButtons(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedButton(
            onPressed: () async => _signInWithGoogle(context),
            child: const Text("logging.google").tr(),
          ),
          Center(child: Padding(padding: const EdgeInsets.all(4.0), child: const Text("or").tr())),
          ElevatedButton(
            onPressed: () async => _signInWithGoogle(context),
            child: const Text("logging.none").tr(),
          ),
        ],
      ),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await AuthService.signInWithGoogle();
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("error.login").tr(namedArgs: {'error': e.toString()})),
        );
      }
    }
  }
}
