import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/widgets/animated_image.dart';
import 'package:spacirtrasa/widgets/map_entity_list/animated_description.dart';
import 'package:spacirtrasa/widgets/map_entity_list/animated_title.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';

class AnimatedTile extends ConsumerWidget {
  final ListItem item;
  final bool isExpanded;

  const AnimatedTile({super.key, required this.item, required this.isExpanded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighlighted = !isExpanded && item.isSelected;

    return InkWell(
      onTap: isExpanded ? item.onShowDetail : item.onSelected,
      onLongPress: item.onLongPress,
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        height: isExpanded ? itemListHeight * 2 : itemListHeight,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: itemListPadding),
        decoration: BoxDecoration(
          color: isHighlighted ? colorScheme.primaryContainer : colorScheme.secondaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: item.isPinned ? Border.all(color: colorScheme.primary, width: 2) : null,
          boxShadow: [
            if (isHighlighted)
              BoxShadow(
                color: colorScheme.primary.withAlpha(170),
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
                  AnimatedTitle(isExpanded, item.title, subtitle: item.subtitle),
                  AnimatedDescription(isExpanded: isExpanded, data: item.description),
                ],
              ),
            ),
            if (item.imageUrl != null) AnimatedImage(isExpanded: isExpanded, imgUrl: item.imageUrl!),
          ],
        ),
      ),
    );
  }
}
