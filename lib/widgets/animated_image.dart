import 'package:flutter/material.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';

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
          width: isExpanded ? maxHeight : 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              placeholder: Assets.images.poiPlaceholder.keyName,
              image: imgUrl,
            ),
          ),
        );
      },
    );
  }
}
