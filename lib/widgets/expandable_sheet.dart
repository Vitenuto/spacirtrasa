import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/providers/expanded.dart';

class ExpandableSheet extends ConsumerWidget {
  final Widget Function(bool) _childBuilder;
  final log = Logger();
  final shrinkedSize = 0.3;

  ExpandableSheet(this._childBuilder, {super.key});

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
                  height: isExpanded ? screenHeight : screenHeight * shrinkedSize,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  duration: kThemeAnimationDuration,
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    color:
                        isExpanded
                            ? colorScheme.surface
                            : colorScheme.surface.withAlpha(230),
                    borderRadius:
                        isExpanded
                            ? const BorderRadius.all(Radius.zero)
                            : const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: _childBuilder(isExpanded),
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
