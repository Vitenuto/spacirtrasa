import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flag.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi_filter.dart';

class AnimatedPoiFilter extends ConsumerStatefulWidget {
  final bool isExpanded;

  const AnimatedPoiFilter(this.isExpanded, {super.key});

  @override
  ConsumerState<AnimatedPoiFilter> createState() => _AnimatedFilterState();
}

class _AnimatedFilterState extends ConsumerState<AnimatedPoiFilter> {
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: kThemeAnimationDuration,
      child:
          widget.isExpanded
              ? Column(
                children: [
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'pois.filter.search-hint'.tr(),
                    ),
                    onChanged:
                        (text) => ref.read(poiFilterProvider.notifier).setFilter(searchText: text),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PoiFlagsToggleRow(),
                  ),
                ],
              )
              : const SizedBox.shrink(),
    );
  }
}

class PoiFlagsToggleRow extends ConsumerWidget {
  const PoiFlagsToggleRow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFlag = ref.watch(poiFilterProvider).flag;
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children:
          PoiFlag.values.map((flag) {
            final isSelected = selectedFlag == flag;

            return IconButton(
              icon: flag.icon,
              onPressed: () => ref.read(poiFilterProvider.notifier).setFilter(flag: flag),
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
