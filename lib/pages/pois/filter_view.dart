import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flags.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi_filter.dart';

class FilterView extends ConsumerWidget {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        SizedBox(height: 16),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            prefixIcon: const Icon(Icons.search),
            hintText: "Jméno zajímavosti...",
          ),
          onChanged: (text) => ref.read(poiFilterProvider.notifier).setFilter(searchText: text),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TrailFlagsToggleRow(),
        ),
      ],
    );
  }
}

class TrailFlagsToggleRow extends ConsumerWidget {
  const TrailFlagsToggleRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFlags = ref.watch(poiFilterProvider).flags;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          PoiFlags.values.map((flag) {
            final isSelected = selectedFlags.contains(flag);

            return IconButton(
              icon: flag.icon,
              onPressed: () {
                final Set<PoiFlags> updatedFlags = Set<PoiFlags>.from(selectedFlags);
                if (isSelected) {
                  updatedFlags.remove(flag);
                } else {
                  updatedFlags.add(flag);
                }
                ref.read(poiFilterProvider.notifier).setFilter(flags: updatedFlags);
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
