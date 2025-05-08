import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/pages/home/animated_poi_tile.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/sorted_poi.dart';
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
  late List<PoiWithDistance> _poisWithDistance;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_setSelected);
      _scrollController.position.isScrollingNotifier.addListener(() => _handleSnap(ref.read(selectedPoiProvider)));
      final initialSelected = ref.read(selectedPoiProvider);
      _handleSnap(initialSelected);
    });
  }

  @override
  Widget build(BuildContext context) {
    _poisWithDistance = ref.watch(sortedPoiProvider);
    if (!widget.isExpanded) {
      ref.listen(selectedPoiProvider, ((_, selectedPoi) => _handleSnap(selectedPoi)));
    }

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        cacheExtent: _fullItemHeight * 15,
        controller: _scrollController,
        itemCount: _poisWithDistance.length + 2,
        // +2 for the title and spacer
        itemBuilder: (context, index) {
          if (index == 0) {
            return AnimatedContainer(
              duration: kThemeAnimationDuration,
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              height: widget.isExpanded ? 0 : itemListHeight,
              child: Text('Zajímavosti kolem:', style: Theme.of(context).textTheme.titleMedium),
            );
          } else if (index == _poisWithDistance.length + 1) {
            // Spacer to allow last item to reach top
            return SizedBox(height: _fullItemHeight * 5);
          }

          final poiWithDistance = _poisWithDistance[index - 1];
          return AnimatedPoiTile(poiWithDistance: poiWithDistance, isExpanded: widget.isExpanded);
        },
      ),
    );
  }

  Future<void> _setSelected() async {
    if (widget.isExpanded) return;

    final offset = _scrollController.offset;
    var index = (offset / _fullItemHeight).round();
    if (index <= 1) index = 1;
    if (ref.read(selectedPoiProvider)?.id == _poisWithDistance[index - 1].poi.id) {
      return; // Skip if the same item is selected
    }
    ref.read(selectedPoiProvider.notifier).setSelected(_poisWithDistance[index - 1].poi);
  }

  Future<void> _handleSnap(Poi? selectedPoi) async {
    if (_scrollController.position.isScrollingNotifier.value) return;
    log.d('Snapping to POI: ${selectedPoi?.title}');

    if (selectedPoi == null) return;

    final poiIndex = _poisWithDistance.indexWhere(
      (poiWithDistance) => poiWithDistance.poi.id == selectedPoi.id,
    );
    final elementIndex = poiIndex + 1;
    final snappedOffset = (elementIndex * _fullItemHeight).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    if (elementIndex == 1 || snappedOffset == _scrollController.offset) {
      return; // Skip snapping to the first item
    }

    log.t(
      'With offset: ${_scrollController.offset} and calculated snappedOffset: $snappedOffset, snapping to POI: ${selectedPoi.title}',
    );
    await _scrollController.animateTo(
      snappedOffset,
      duration: kThemeAnimationDuration,
      curve: Curves.easeOut,
    );
  }
}
