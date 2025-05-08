import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/pages/pois/poi_detail.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/widgets/animated_description.dart';
import 'package:spacirtrasa/widgets/animated_image.dart';
import 'package:spacirtrasa/widgets/animated_title.dart';

class AnimatedPoiTile extends ConsumerWidget {
  final PoiWithDistance poiWithDistance;
  final bool isExpanded;

  const AnimatedPoiTile({super.key, required this.poiWithDistance, required this.isExpanded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighlighted =
        !isExpanded && ref.watch(selectedPoiProvider)?.id == poiWithDistance.poi.id;

    return InkWell(
      onTap:
          isExpanded
              ? () => showPoiDetail(context, poiWithDistance.poi)
              : () => onPoiClicked(poiWithDistance.poi, ref),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        height: isExpanded ? itemListHeight * 2 : itemListHeight,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: itemListPadding),
        decoration: BoxDecoration(
          color: isHighlighted ? colorScheme.primaryContainer : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            if (isHighlighted)
              BoxShadow(
                color: colorScheme.primary.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Row(
          spacing: 4,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedTitle(
                    isExpanded,
                    poiWithDistance.poi.title,
                    length: poiWithDistance.distance,
                  ),
                  AnimatedDescription(
                    isExpanded: isExpanded,
                    data: poiWithDistance.poi.markdownLessData,
                  ),
                ],
              ),
            ),
            AnimatedImage(isExpanded: isExpanded, imgUrl: poiWithDistance.poi.imgUrl),
          ],
        ),
      ),
    );
  }

  onPoiClicked(Poi poi, WidgetRef ref) {
    ref.read(selectedPoiProvider.notifier).setSelected(poi);
  }
}
