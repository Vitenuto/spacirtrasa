import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/providers/expanded.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/utils/utils.dart';
import 'package:spacirtrasa/widgets/map_entity_list/animated_tile.dart';
import 'package:spacirtrasa/widgets/map_entity_list/list_item.dart';
import 'package:spacirtrasa/widgets/snap_list_helper.dart';

class ExpandableList extends ConsumerStatefulWidget {
  final bool isExpanded;
  final String listTitle;
  final List<ListItem> items;
  final Widget Function(bool) filterBuilder;

  const ExpandableList({
    super.key,
    required this.isExpanded,
    required this.listTitle,
    required this.items,
    required this.filterBuilder,
  });

  @override
  ConsumerState<ExpandableList> createState() => _SnapListState();
}

class _SnapListState extends ConsumerState<ExpandableList> {
  final log = Logger();
  final ScrollController _scrollController = ScrollController();

  bool dragStartedAtTop = false;
  bool isSnapping = false;

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
    ref.listen(expandedProvider, (_, isExpanded) => _onExpanded(isExpanded));

    return NotificationListener<ScrollNotification>(
      onNotification: onListNotification,
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0),
        child: ListView.builder(
          padding: EdgeInsets.all(8),
          cacheExtent: fullItemHeight * 15,
          controller: _scrollController,
          itemCount: widget.items.length + 2,
          // +2 for the title and spacer
          itemBuilder: (context, index) {
            if (index == 0) {
              return AnimatedSwitcher(
                duration: kThemeAnimationDuration,
                child:
                    widget.isExpanded
                        ? widget.filterBuilder(widget.isExpanded)
                        : Container(
                          alignment: Alignment.center,
                          height: itemListHeight,
                          child: Text(
                            widget.listTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
              );
            } else if (index == widget.items.length + 1) {
              // Spacer to allow last item to reach top
              return SizedBox(height: fullItemHeight * 5);
            }

            return AnimatedTile(item: widget.items[index - 1], isExpanded: widget.isExpanded);
          },
        ),
      ),
    );
  }

  bool onListNotification(ScrollNotification notification) {
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
  }

  void _onExpanded(bool isExpanded) {
    if (!isExpanded) _snapToSelected();
  }

  void _setSelected() {
    if (widget.isExpanded) return;

    final offset = _scrollController.offset;
    var index = (offset / fullItemHeight).round() - 1; // -1 to account for the title
    index = index.clamp(0, widget.items.length - 1);
    final selectedItem = widget.items[index];

    // TODO Not ideal, probably the provider should be stored in the listItem as well
    if (ref.read(selectedTrailProvider)?.id == selectedItem.id ||
        ref.read(selectedPoiProvider)?.id == selectedItem.id) {
      return; // Skip if the item is already selected
    }

    selectedItem.onSelected();
  }

  void _onScrollChange() {
    if (isSnapping || widget.isExpanded || _scrollController.position.isScrollingNotifier.value) {
      return;
    }
    _snapToSelected();
  }

  Future<void> _snapToSelected() async {
    final listIndex =
        widget.items.indexWhere((item) => item.isSelected) + 1; // +1 to account for the title
    if (listIndex <= 1) return; // Skip snapping to the first item

    log.t('Snapping to index: ${listIndex - 1}');
    isSnapping = true;
    await handleSnap(_scrollController, listIndex);
    isSnapping = false;
  }
}
