import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_length.dart';
import 'package:spacirtrasa/pages/trails/animated_filter.dart';
import 'package:spacirtrasa/pages/trails/trail_tile.dart';
import 'package:spacirtrasa/providers/map_entity/trail/filtered_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/utils/constants.dart';

class SnapList extends ConsumerStatefulWidget {
  final bool isExpanded;

  const SnapList(this.isExpanded, {super.key});

  @override
  ConsumerState<SnapList> createState() => _SnapListState();
}

class _SnapListState extends ConsumerState<SnapList> {
  final log = Logger();
  final ScrollController _scrollController = ScrollController();

  double get _fullItemHeight => itemListHeight + (itemListPadding * 2);
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
                    height: widget.isExpanded ? 0 : itemListHeight,
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
