import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/services/supplementary.dart';
import 'package:url_launcher/url_launcher.dart';

class VillagePage extends ConsumerWidget {
  static const route = "/village";

  const VillagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final markdown = ref.watch(aboutVillageTextProvider);

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 8),
      children: [
        Padding(
          padding: EdgeInsets.all(8),
          child: Assets.images.logoVesniceRoku.image(height: 250),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            OutlinedButton.icon(
              icon: const Icon(Icons.directions_bus),
              label: Text('village.bus-connections'.tr()),
              onPressed: () => launchUrl(Uri.parse("https://www.idsjmk.cz/connection-finder/search")),
            ),
            OutlinedButton.icon(
              icon: const Icon(Icons.newspaper),
              label: Text('village.news'.tr()),
              onPressed: () => launchUrl(Uri.parse("https://www.orechovubrna.cz/aktuality/")),
            ),
          ],
        ),
        markdown.when(
          data: (data) => MarkdownBody(data: data),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Text('Error: $err'),
        ),
      ],
    );
  }
}
