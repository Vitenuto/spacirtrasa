import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/models/poi_with_distance.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/sorted_poi.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';

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
  late List<PoiWithDistance> _poisWithDistance;

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
    _poisWithDistance = ref.watch(sortedPoiProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ListView.builder(
        cacheExtent: _fullItemHeight * 15,
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        itemCount: _poisWithDistance.length + 2,
        // +2 for the title and spacer
        itemBuilder: (context, index) {
          if (index == 0) {
            return AnimatedContainer(
              duration: kThemeAnimationDuration,
              curve: Curves.easeInOut,
              alignment: Alignment.center,
              height: widget.isExpanded ? 0 : _itemHeight,
              child: Text('Interests around:', style: Theme.of(context).textTheme.titleMedium),
            );
          } else if (index == _poisWithDistance.length + 1) {
            // Spacer to allow last item to reach top
            return SizedBox(height: _fullItemHeight * 3);
          }

          final poiWithDistance = _poisWithDistance[index - 1];
          return PoiTile(poiWithDistance: poiWithDistance, isExpanded: widget.isExpanded);
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

  Future<void> _handleSnap() async {
    if (widget.isExpanded || _scrollController.position.isScrollingNotifier.value) return;

    final selectedPoi = ref.watch(selectedPoiProvider);
    if (selectedPoi == null) return;

    final poiIndex = _poisWithDistance.indexWhere((poiWithDistance) => poiWithDistance.poi.id == selectedPoi.id);
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

class PoiTile extends ConsumerWidget {
  final PoiWithDistance poiWithDistance;
  final bool isExpanded;

  const PoiTile({super.key, required this.poiWithDistance, required this.isExpanded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isHighlighted = !isExpanded && ref.watch(selectedPoiProvider)?.id == poiWithDistance.poi.id;

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: isExpanded ? _itemHeight * 2 : _itemHeight,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: _itemPadding),
      decoration: BoxDecoration(
        color: isHighlighted ? colorScheme.primaryContainer : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
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
                AnimatedTitle(isExpanded: isExpanded, poiWithDistance: poiWithDistance),
                AnimatedDescription(
                  isExpanded: isExpanded,
                  data: poiWithDistance.poi.markdownLessData,
                ),
              ],
            ),
          ),
          AnimatedImage(isExpanded: isExpanded, imgUrl: poiWithDistance.poi.imgUrl),
        ],
      ),
    );
  }
}

class AnimatedTitle extends ConsumerWidget {
  const AnimatedTitle({super.key, required this.isExpanded, required this.poiWithDistance});

  final bool isExpanded;
  final PoiWithDistance poiWithDistance;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final userPosition = ref.watch(positionProvider);

    return AnimatedAlign(
      alignment: isExpanded ? Alignment.centerLeft : Alignment.center,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AnimatedDefaultTextStyle(
            duration: kThemeAnimationDuration,
            curve: Curves.easeInOut,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: isExpanded ? 14 : 18,
              fontWeight: isExpanded ? FontWeight.w500 : FontWeight.w400,
            ),
            child: Text(poiWithDistance.poi.title),
          ),
          userPosition != null ? Text(' (${poiWithDistance.distance.toStringAsFixed(0)} m)') : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class AnimatedDescription extends StatelessWidget {
  final bool isExpanded;
  final String data;

  const AnimatedDescription({super.key, required this.isExpanded, required this.data});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: AnimatedCrossFade(
        crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: kThemeAnimationDuration,
        firstChild: Text(
          data,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 14, color: Colors.grey[800]),
        ),
        secondChild: SizedBox.shrink(),
      ),
    );
  }
}

class AnimatedImage extends StatelessWidget {
  final bool isExpanded;
  final String imgUrl;

  const AnimatedImage({super.key, required this.isExpanded, required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        return AnimatedContainer(
          duration: kThemeAnimationDuration,
          curve: Curves.easeInOut,
          height: isExpanded ? maxHeight : 0,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FadeInImage.assetNetwork(
              placeholder: Assets.images.poiPlaceholder.keyName,
              image: imgUrl,
            ),
          ),
        );
      },
    );
  }
}
