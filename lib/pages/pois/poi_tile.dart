import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/pages/home/snap_list.dart';
import 'package:spacirtrasa/pages/pois/poi_detail.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';

class PoiTile extends ConsumerWidget {
  final PoiWithDistance poiWithDistance;

  const PoiTile(this.poiWithDistance, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: () => showPoiDetail(context, poiWithDistance.poi),
      child: Container(
        height: itemHeight * 2,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: itemPadding),
        decoration: BoxDecoration(
          color: colorScheme.surface,
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
                  Title(poiWithDistance),
                  Description(poiWithDistance.poi.markdownLessData),
                ],
              ),
            ),
            AnimatedImage(poiWithDistance.poi.imgUrl),
          ],
        ),
      ),
    );
  }
}

class Title extends ConsumerWidget {
  const Title(this.poiWithDistance, {super.key});

  final PoiWithDistance poiWithDistance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final userPosition = ref.watch(positionProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          poiWithDistance.poi.title,
          style: TextStyle(color: colorScheme.onSurface, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        userPosition != null
            ? Text(' (${poiWithDistance.distance.toStringAsFixed(0)} m)')
            : SizedBox.shrink(),
      ],
    );
  }
}

class Description extends StatelessWidget {
  final String data;

  const Description(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Text(
        data,
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
      ),
    );
  }
}

class AnimatedImage extends StatelessWidget {
  final String imgUrl;

  const AnimatedImage(this.imgUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        return SizedBox(
          height: maxHeight,
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
