import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_with_distance.dart';
import 'package:spacirtrasa/pages/home/animated_poi_tile.dart';
import 'package:spacirtrasa/providers/expanded.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/sorted_poi.dart';
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

  late List<PoiWithDistance> _poisWithDistance;

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
    _poisWithDistance = ref.watch(sortedPoiProvider);
    ref.listen(expandedProvider, (_, isExpanded) => _onExpanded(isExpanded));

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ListView.builder(
        padding: EdgeInsets.all(8),
        cacheExtent: fullItemHeight * 15,
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
            return SizedBox(height: fullItemHeight * 5);
          }

          final poiWithDistance = _poisWithDistance[index - 1];
          return AnimatedPoiTile(poiWithDistance: poiWithDistance, isExpanded: widget.isExpanded);
        },
      ),
    );
  }

  void _onExpanded(final bool isExpanded) {
    if (!isExpanded) _snapToSelected();
  }

  void _setSelected() async {
    if (widget.isExpanded) return;

    final offset = _scrollController.offset;
    var index = (offset / fullItemHeight).round() - 1; // -1 to account for the title
    index = index.clamp(0, _poisWithDistance.length - 1);
    final selectedPoi = _poisWithDistance[index].poi;
    if (ref.read(selectedPoiProvider)?.id == selectedPoi.id) {
      return; // Skip if the same item is selected
    }
    ref.read(selectedPoiProvider.notifier).setSelected(selectedPoi);
  }

  void _onScrollChange() async {
    if (widget.isExpanded || _scrollController.position.isScrollingNotifier.value) return;
    _snapToSelected();
  }

  void _snapToSelected() {
    final selectedPoi = ref.read(selectedPoiProvider);
    if (selectedPoi == null) return;

    final poiIndex = _poisWithDistance.indexWhere(
      (poiWithDistance) => poiWithDistance.poi.id == selectedPoi.id,
    );
    final listIndex = poiIndex + 1; // +1 to account for the title
    if (listIndex == 1) return; // Skip snapping to the first item

    log.t('Snapping to: ${selectedPoi.title}');
    handleSnap(_scrollController, listIndex);
  }
}
