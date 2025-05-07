import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/providers/map_entity/trail/sorted_trail.dart';

class AnimatedTitle extends ConsumerWidget {
  final bool isExpanded;

  const AnimatedTitle(this.isExpanded, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trailWithLength = ref.watch(sortedTrailProvider).first;
    final colorScheme = Theme.of(context).colorScheme;

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
            child: Text(trailWithLength.trail.title),
          ),
          Text(' (${(trailWithLength.length / 1000).toStringAsFixed(2)} km)'),
        ],
      ),
    );
  }
}
