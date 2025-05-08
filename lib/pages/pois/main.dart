import 'package:flutter/material.dart';
import 'package:spacirtrasa/pages/pois/poi_list_view.dart';

class PoisPage extends StatelessWidget {
  static const route = "/pois";

  const PoisPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(color: colorScheme.surface),
      child: PoiListView(),
    );
  }
}
