import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_length.dart';
import 'package:spacirtrasa/pages/trails/animated_description.dart';
import 'package:spacirtrasa/pages/trails/animated_title.dart';
import 'package:spacirtrasa/pages/trails/trail_detail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/utils/constants.dart';

class AnimatedTrailTile extends ConsumerWidget {
  final TrailWithLength trailWithLength;
  final bool isExpanded;

  const AnimatedTrailTile({super.key, required this.trailWithLength, required this.isExpanded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighlighted =
        !isExpanded && ref.watch(selectedTrailProvider)?.id == trailWithLength.trail.id;
    final isPinned = ref.watch(pinnedTrailProvider)?.id == trailWithLength.trail.id;

    return InkWell(
      onTap: isExpanded ? () => showTrailDetail(context, trailWithLength.trail) : () => onTrailClicked(trailWithLength.trail, ref),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        height: isExpanded ? itemListHeight * 2 : itemListHeight,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: itemListPadding),
        decoration: BoxDecoration(
          color: isHighlighted ? colorScheme.primaryContainer : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
          border:
          isPinned
              ? Border.all(color: colorScheme.primary, width: 2)
              : null,
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
                    trailWithLength.trail.title,
                    subtitle: ' (${(trailWithLength.length / 1000).toStringAsFixed(2)} km)',
                  ),
                  AnimatedDescription(
                    isExpanded: isExpanded,
                    data: trailWithLength.trail.markdownLessData,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTrailClicked(Trail trail, WidgetRef ref) {
    ref.read(pinnedTrailProvider.notifier).setPinned(trail);
    ref.read(selectedTrailProvider.notifier).setSelected(trail);
  }
}