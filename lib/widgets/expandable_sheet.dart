import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/providers/expanded.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/widgets/map_entity_list/expandable_list.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';

class ExpandableSheet extends ConsumerWidget {
  final String listTitle;
  final List<ListItem> items;
  final Widget Function(bool) filterBuilder;

  final log = Logger();

  ExpandableSheet({
    super.key,
    required this.listTitle,
    required this.items,
    required this.filterBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isExpanded = ref.watch(expandedProvider);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: isExpanded ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 8),
      duration: kThemeAnimationDuration,
      child: Stack(
        clipBehavior: Clip.none, // allow overflow for the button
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (!isExpanded) SizedBox(height: 8),
              Flexible(
                child: AnimatedContainer(
                  height: isExpanded ? screenHeight : screenHeight * expandableSheetSize,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  duration: kThemeAnimationDuration,
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color: isExpanded ? colorScheme.surface : colorScheme.surface.withAlpha(230),
                    borderRadius:
                        isExpanded
                            ? const BorderRadius.all(Radius.zero)
                            : const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: ExpandableList(
                    isExpanded: isExpanded,
                    listTitle: listTitle,
                    items: items,
                    filterBuilder: filterBuilder,
                  ),
                ),
              ),
            ],
          ),

          ExpandButton(),
        ],
      ),
    );
  }
}

class ExpandButton extends ConsumerWidget {
  const ExpandButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isExpanded = ref.watch(expandedProvider);
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AnimatedPositioned(
      duration: kThemeAnimationDuration,
      top: isExpanded ? -8 : 0,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onVerticalDragUpdate: (details) => _onVerticalDragUpdate(details, isExpanded, ref),
          onTap: () => ref.read(expandedProvider.notifier).setExpanded(!isExpanded),
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            alignment: Alignment.center,
            width: isExpanded ? 92 : 64,
            height: isExpanded ? 36 : 30,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
            ),
            child: AnimatedSwitcher(
              duration: kThemeAnimationDuration,
              transitionBuilder:
                  (child, animation) => FadeTransition(opacity: animation, child: child),
              child: Icon(
                isExpanded ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_up,
                color: colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details, bool isExpanded, WidgetRef ref) {
    // If user drags downward, details.delta.dy > 0
    if (details.delta.dy > 5 && isExpanded) {
      ref.read(expandedProvider.notifier).setExpanded(false);
    } else if (details.delta.dy < -5 && !isExpanded) {
      ref.read(expandedProvider.notifier).setExpanded(true);
    }
  }
}
