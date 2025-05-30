import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';

class HomePage extends ConsumerWidget {
  static final log = Logger();
  static const route = "/home";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markdown = ref.watch(markdownProvider);

    log.t(Assets.texts.appIntroduction);

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

final markdownProvider = FutureProvider<String>(
  (ref) async => await rootBundle.loadString(Assets.texts.appIntroduction),
);
