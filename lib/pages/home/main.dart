import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/services/supplementary.dart';

class HomePage extends ConsumerWidget {
  static const route = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markdown = ref.watch(homeTextProvider);

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        Assets.images.appLogo.image(width: 250, height: 250, fit: BoxFit.scaleDown),
        const SizedBox(height: 48.0),
        markdown.when(
          data: (data) => MarkdownBody(data: data),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text('Error: $err'),
        ),
      ],
    );
  }
}
