import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'expandable_sheet.dart';
import 'main_map.dart';

class HomePage extends ConsumerWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(children: [const MainMap(), Align(alignment: Alignment.bottomCenter, child: ExpandableSheet())]);
  }
}
