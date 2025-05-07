import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_flags.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_filter.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail_length_bounds.dart';

class AnimatedFilter extends ConsumerStatefulWidget {
  final bool isExpanded;

  const AnimatedFilter(this.isExpanded, {super.key});

  @override
  ConsumerState<AnimatedFilter> createState() => _AnimatedFilterState();
}

class _AnimatedFilterState extends ConsumerState<AnimatedFilter> {
  RangeValues? _rangeValues;

  @override
  Widget build(BuildContext context) {
    final lengthBounds = ref.watch(trailLengthBoundsProvider);
    if (lengthBounds != null) {
      _rangeValues ??= RangeValues(lengthBounds.$1, lengthBounds.$2);
    }

    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child:
          widget.isExpanded && lengthBounds != null
              ? Column(
                children: [
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                      hintText: "Jméno trasy...",
                    ),
                    onChanged:
                        (text) =>
                            ref.read(trailFilterProvider.notifier).setFilter(searchText: text),
                  ),
                  RangeSlider(
                    min: lengthBounds.$1,
                    max: lengthBounds.$2,
                    values: _rangeValues!,
                    onChanged: (RangeValues newValues) {
                      ref
                          .read(trailFilterProvider.notifier)
                          .setFilter(bounds: (newValues.start, newValues.end));
                      setState(() {
                        _rangeValues = newValues;
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Text("${(_rangeValues!.start / 1000).toStringAsFixed(2)} km"),
                        const Spacer(),
                        TrailFlagsToggleRow(),
                        const Spacer(),
                        Text("${(_rangeValues!.end / 1000).toStringAsFixed(2)} km"),
                      ],
                    ),
                  ),
                ],
              )
              : const SizedBox.shrink(),
    );
  }
}

class TrailFlagsToggleRow extends ConsumerWidget {
  const TrailFlagsToggleRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFlags = ref.watch(trailFilterProvider).flags;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      children:
          TrailFlags.values.map((flag) {
            final isSelected = selectedFlags.contains(flag);

            return IconButton(
              icon: flag.icon,
              onPressed: () {
                final List<TrailFlags> updatedFlags = List.from(selectedFlags);
                if (isSelected) {
                  updatedFlags.remove(flag);
                } else {
                  updatedFlags.add(flag);
                }
                ref.read(trailFilterProvider.notifier).setFilter(flags: updatedFlags);
              },
              color: isSelected ? colorScheme.primary : null,
              style: IconButton.styleFrom(
                backgroundColor: isSelected ? colorScheme.primary.withValues(alpha: 0.1) : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                  side:
                      isSelected
                          ? BorderSide(color: colorScheme.primary, width: 1)
                          : BorderSide.none,
                ),
              ),
            );
          }).toList(),
    );
  }
}
