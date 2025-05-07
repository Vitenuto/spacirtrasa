import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:spacirtrasa/models/trail_with_length.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_filter.dart';

class AnimatedFilter extends ConsumerWidget {
  final bool isExpanded;
  final List<TrailWithLength> trailsWithLength;

  const AnimatedFilter(this.isExpanded, this.trailsWithLength, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final minLength = _getMinLength();
    final maxLength = _getMaxLength();

    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child:
          isExpanded
              ? Column(
                children: [
                  TextField(
                    onChanged:
                        (text) =>
                            ref.read(trailFilterProvider.notifier).setFilter(searchText: text),
                  ),
                  FlutterSlider(
                    tooltip: FlutterSliderTooltip(),
                    values: [minLength, maxLength],
                    handlerWidth: 25,
                    handlerHeight: 25,
                    rangeSlider: true,
                    max: maxLength,
                    min: minLength,
                    onDragCompleted:
                        (handlerIndex, lowerValue, upperValue) => ref
                            .read(trailFilterProvider.notifier)
                            .setFilter(bounds: (lowerValue, upperValue)),
                  ),
                ],
              )
              : const SizedBox.shrink(),
    );
  }

  double _getMaxLength() {
    if (trailsWithLength.isEmpty) return 0;
    return trailsWithLength
        .map((trailWithLength) => trailWithLength.length)
        .reduce((a, b) => a > b ? a : b);
  }

  double _getMinLength() {
    if (trailsWithLength.isEmpty) return 0;
    return trailsWithLength
        .map((trailWithLength) => trailWithLength.length)
        .reduce((a, b) => a < b ? a : b);
  }
}
