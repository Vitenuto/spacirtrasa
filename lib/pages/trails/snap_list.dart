import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_length.dart';
import 'package:spacirtrasa/pages/trails/animated_description.dart';
import 'package:spacirtrasa/pages/trails/animated_filter.dart';
import 'package:spacirtrasa/pages/trails/animated_title.dart';
import 'package:spacirtrasa/providers/map_entity/trail/filtered_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';

const _itemHeight = 45.0;
const _itemPadding = 4.0;

class SnapList extends ConsumerStatefulWidget {
  final bool isExpanded;

  const SnapList(this.isExpanded, {super.key});

  @override
  ConsumerState<SnapList> createState() => _SnapListState();
}

class _SnapListState extends ConsumerState<SnapList> {
  final log = Logger();
  final ScrollController _scrollController = ScrollController();

  double get _fullItemHeight => _itemHeight + (_itemPadding * 2);
  late List<TrailWithLength> trailsWithLength;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_setSelected);
      _scrollController.position.isScrollingNotifier.addListener(_handleSnap);
    });
  }

  @override
  Widget build(BuildContext context) {
    trailsWithLength = ref.watch(filteredTrailProvider);

    return Padding(
      padding: const EdgeInsets.all(8).copyWith(top: 4.0),
      child: Column(
        children: [
          AnimatedFilter(widget.isExpanded),
          Expanded(
            child: ListView.builder(
              cacheExtent: _fullItemHeight * 15,
              controller: _scrollController,
              itemCount: trailsWithLength.length + 2,
              // +2 for the title and spacer
              itemBuilder: (context, index) {
                if (index == 0) {
                  return AnimatedContainer(
                    duration: kThemeAnimationDuration,
                    curve: Curves.easeInOut,
                    alignment: Alignment.center,
                    height: widget.isExpanded ? 0 : _itemHeight,
                    child: Text(
                      'Stiskem připnete:',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  );
                } else if (index == trailsWithLength.length + 1) {
                  // Spacer to allow last item to reach top
                  return SizedBox(height: _fullItemHeight * 3);
                }

                final trailWithLength = trailsWithLength[index - 1];
                return TrailTile(trailWithLength: trailWithLength, isExpanded: widget.isExpanded);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _setSelected() async {
    if (widget.isExpanded) return;

    final offset = _scrollController.offset;
    var index = (offset / _fullItemHeight).round();
    if (index <= 1) index = 1;
    if (ref.read(selectedTrailProvider)?.id == trailsWithLength[index - 1].trail.id) {
      return; // Skip if the same item is selected
    }
    ref.read(selectedTrailProvider.notifier).setSelected(trailsWithLength[index - 1].trail);
  }

  Future<void> _handleSnap() async {
    if (widget.isExpanded || _scrollController.position.isScrollingNotifier.value) return;

    final selectedTrail = ref.watch(selectedTrailProvider);
    if (selectedTrail == null) return;

    final trailIndex = trailsWithLength.indexWhere(
      (trailWithLength) => trailWithLength.trail.id == selectedTrail.id,
    );
    final elementIndex = trailIndex + 1;
    final snappedOffset = (elementIndex * _fullItemHeight).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    if (elementIndex == 1 || snappedOffset == _scrollController.offset) {
      return; // Skip snapping to the first item
    }

    log.t(
      'With offset: ${_scrollController.offset} and calculated snappedOffset: $snappedOffset, snapping to Trail: ${selectedTrail.title}',
    );
    await _scrollController.animateTo(
      snappedOffset,
      duration: kThemeAnimationDuration,
      curve: Curves.easeOut,
    );
  }
}

class TrailTile extends ConsumerWidget {
  final TrailWithLength trailWithLength;
  final bool isExpanded;

  const TrailTile({super.key, required this.trailWithLength, required this.isExpanded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighlighted =
        !isExpanded && ref.watch(selectedTrailProvider)?.id == trailWithLength.trail.id;
    final isPinned = ref.watch(pinnedTrailProvider)?.id == trailWithLength.trail.id;

    return InkWell(
      onTap: () => onTrailClicked(trailWithLength.trail, ref),
      child: AnimatedContainer(
        duration: kThemeAnimationDuration,
        height: isExpanded ? _itemHeight * 2 : _itemHeight,
        padding: const EdgeInsets.all(8),
        margin: const EdgeInsets.symmetric(vertical: _itemPadding),
        decoration: BoxDecoration(
          color: isHighlighted ? colorScheme.primaryContainer : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border:
              isPinned
                  ? Border.all(color: colorScheme.primary, width: 2)
                  : Border.all(color: Colors.transparent, width: 2),
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
