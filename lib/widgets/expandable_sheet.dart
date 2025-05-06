import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

class ExpandableSheet extends ConsumerStatefulWidget {
  final Widget Function(bool) _childBuilder;

  const ExpandableSheet(this._childBuilder, {super.key});

  @override
  ConsumerState<ExpandableSheet> createState() => _ExpandableSheetState();
}

class _ExpandableSheetState extends ConsumerState<ExpandableSheet> {
  final log = Logger();
  final shrinkedSize = 0.3;

  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
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
                            ? colorScheme.primaryContainer
                            : colorScheme.primaryContainer.withAlpha(230),
                    borderRadius:
                        isExpanded
                            ? const BorderRadius.all(Radius.zero)
                            : const BorderRadius.vertical(top: Radius.circular(16)),
                  ),
                  child: widget._childBuilder(isExpanded),
                ),
              ),
            ],
          ),

          ExpandButton(isExpanded, onTap: () => setState(() => isExpanded = !isExpanded)),
        ],
      ),
    );
  }
}

class ExpandButton extends StatelessWidget {
  final VoidCallback onTap;
  final bool isExpanded;

  const ExpandButton(this.isExpanded, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return AnimatedPositioned(
      duration: kThemeAnimationDuration,
      top: isExpanded ? -8 : 0,
      left: 0,
      right: 0,
      child: Center(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: AnimatedContainer(
            duration: kThemeAnimationDuration,
            alignment: Alignment.center,
            width: isExpanded ? 72 : 48,
            height: isExpanded ? 28 : 24,
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
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
