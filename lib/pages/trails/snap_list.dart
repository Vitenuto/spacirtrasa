import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail_with_length.dart';
import 'package:spacirtrasa/pages/trails/animated_filter.dart';
import 'package:spacirtrasa/pages/trails/animated_trail_tile.dart';
import 'package:spacirtrasa/providers/expanded.dart';
import 'package:spacirtrasa/providers/map_entity/trail/filtered_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/utils/utils.dart';
import 'package:spacirtrasa/widgets/snap_list_helper.dart';

class SnapList extends ConsumerStatefulWidget {
  final bool isExpanded;

  const SnapList(this.isExpanded, {super.key});

  @override
  ConsumerState<SnapList> createState() => _SnapListState();
}

class _SnapListState extends ConsumerState<SnapList> {
  final log = Logger();
  final ScrollController _scrollController = ScrollController();

  late List<TrailWithLength> _trailsWithLength;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_setSelected);
      _scrollController.position.isScrollingNotifier.addListener(_onScrollChange);
      _snapToSelected();
    });
  }

  @override
  Widget build(BuildContext context) {
    _trailsWithLength = ref.watch(filteredTrailProvider);
    ref.listen(expandedProvider, (_, isExpanded) => _onExpanded(isExpanded));
    bool dragStartedAtTop = false;

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification is ScrollStartNotification) {
          // Detect if user starts dragging at top
          dragStartedAtTop = _scrollController.offset <= 0.0;
        }

        if (notification is ScrollEndNotification) {
          dragStartedAtTop = false;
        }

        if (notification is OverscrollNotification &&
            dragStartedAtTop &&
            notification.overscroll < 0 && // pull down
            widget.isExpanded) {
          ref.read(expandedProvider.notifier).setExpanded(false);
          dragStartedAtTop = false;
          return true;
        }

        return false;
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          cacheExtent: fullItemHeight * 15,
          controller: _scrollController,
          itemCount: _trailsWithLength.length + 2,
          // +2 for the title and spacer
          itemBuilder: (context, index) {
            if (index == 0) {
              return AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child:
                    widget.isExpanded
                        ? AnimatedFilter(widget.isExpanded)
                        : Container(
                          alignment: Alignment.center,
                          height: itemListHeight,
                          child: Text(
                            'Stiskem připnete:',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
              );
            } else if (index == _trailsWithLength.length + 1) {
              // Spacer to allow last item to reach top
              return SizedBox(height: fullItemHeight * 5);
            }

            final trailWithLength = _trailsWithLength[index - 1];
            return AnimatedTrailTile(
              trailWithLength: trailWithLength,
              isExpanded: widget.isExpanded,
            );
          },
        ),
      ),
    );
  }

  // bool _onScrollNotification(ScrollNotification notification, bool dragStartedAtTop)

  void _onExpanded(final bool isExpanded) {
    if (!isExpanded) _snapToSelected();
  }

  void _setSelected() {
    if (widget.isExpanded) return;

    final offset = _scrollController.offset;
    var index = (offset / fullItemHeight).round() - 1; // -1 to account for the title
    index = index.clamp(0, _trailsWithLength.length - 1);
    final selectedTrail = _trailsWithLength[index].trail;
    if (ref.read(selectedTrailProvider)?.id == selectedTrail.id) {
      return; // Skip if the same item is selected
    }
    ref.read(selectedTrailProvider.notifier).setSelected(selectedTrail);
  }

  void _onScrollChange() async {
    if (widget.isExpanded || _scrollController.position.isScrollingNotifier.value) return;
    _snapToSelected();
  }

  void _snapToSelected() {
    final selectedTrail = ref.read(selectedTrailProvider);
    if (selectedTrail == null) return;

    final listIndex =
        _trailsWithLength.indexWhere(
          (trailWithLength) => trailWithLength.trail.id == selectedTrail.id,
        ) +
        1; // +1 to account for the title
    if (listIndex == 1) return; // Skip snapping to the first item

    log.t('Snapping to: ${selectedTrail.title}');
    handleSnap(_scrollController, listIndex);
  }
}
