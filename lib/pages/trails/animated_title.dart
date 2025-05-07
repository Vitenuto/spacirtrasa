import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimatedTitle extends ConsumerWidget {
  final bool isExpanded;
  final String title;
  final String? subtitle;

  const AnimatedTitle(this.isExpanded, this.title, {super.key, this.subtitle});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            child: Text(title),
          ),
          if (subtitle != null) Text(subtitle!),
        ],
      ),
    );
  }
}
