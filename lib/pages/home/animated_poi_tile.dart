import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/models/poi_with_distance.dart';
import 'package:spacirtrasa/pages/home/snap_list.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';

class AnimatedPoiTile extends ConsumerWidget {
  final PoiWithDistance poiWithDistance;
  final bool isExpanded;

  const AnimatedPoiTile({super.key, required this.poiWithDistance, required this.isExpanded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighlighted = !isExpanded && ref.watch(selectedPoiProvider)?.id == poiWithDistance.poi.id;

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: isExpanded ? itemHeight * 2 : itemHeight,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: itemPadding),
      decoration: BoxDecoration(
        color: isHighlighted ? colorScheme.primaryContainer : colorScheme.surface,
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
                AnimatedTitle(isExpanded: isExpanded, poiWithDistance: poiWithDistance),
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
    );
  }
}

class AnimatedTitle extends ConsumerWidget {
  const AnimatedTitle({super.key, required this.isExpanded, required this.poiWithDistance});

  final bool isExpanded;
  final PoiWithDistance poiWithDistance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final userPosition = ref.watch(positionProvider);

    return AnimatedAlign(
      alignment: isExpanded ? Alignment.centerLeft : Alignment.center,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedDefaultTextStyle(
            duration: kThemeAnimationDuration,
            curve: Curves.easeInOut,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: isExpanded ? 14 : 18,
              fontWeight: isExpanded ? FontWeight.w500 : FontWeight.w400,
            ),
            child: Text(poiWithDistance.poi.title),
          ),
          userPosition != null ? Text(' (${poiWithDistance.distance.toStringAsFixed(0)} m)') : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class AnimatedDescription extends StatelessWidget {
  final bool isExpanded;
  final String data;

  const AnimatedDescription({super.key, required this.isExpanded, required this.data});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimatedCrossFade(
        crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: kThemeAnimationDuration,
        firstChild: Text(
          data,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: Colors.grey[800]),
        ),
        secondChild: SizedBox.shrink(),
      ),
    );
  }
}

class AnimatedImage extends StatelessWidget {
  final bool isExpanded;
  final String imgUrl;

  const AnimatedImage({super.key, required this.isExpanded, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        return AnimatedContainer(
          duration: kThemeAnimationDuration,
          curve: Curves.easeInOut,
          height: isExpanded ? maxHeight : 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage.assetNetwork(
              placeholder: Assets.images.poiPlaceholder.keyName,
              image: imgUrl,
            ),
          ),
        );
      },
    );
  }
}
