import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/pages/pois/poi_detail.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/widgets/animated_description.dart';
import 'package:spacirtrasa/widgets/animated_image.dart';
import 'package:spacirtrasa/widgets/animated_title.dart';

class PoiTile extends ConsumerWidget {
  final PoiWithDistance poiWithDistance;

  const PoiTile(this.poiWithDistance, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => showPoiDetail(context, poiWithDistance.poi),
      child: Container(
        height: itemListHeight * 2,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: itemListPadding),
        decoration: BoxDecoration(
          color: colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          spacing: 4,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedTitle(true, poiWithDistance.poi.title, length: poiWithDistance.distance),
                  AnimatedDescription(isExpanded: true, data: poiWithDistance.poi.markdownLessData),
                ],
              ),
            ),
            AnimatedImage(isExpanded: true, imgUrl: poiWithDistance.poi.imgUrl),
          ],
        ),
      ),
    );
  }
}
