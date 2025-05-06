import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/models/poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';

const _itemHeight = 50.0;
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
  late List<Poi> pois;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_setSelected);
      _scrollController.position.isScrollingNotifier.addListener(_handleSnap);
    });
  }

  @override
  void didUpdateWidget(covariant SnapList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isExpanded != oldWidget.isExpanded) {
      // If transitioning to collapsed (isExpanded = false), reset scroll position
      if (!widget.isExpanded) {
        _scrollController.animateTo(0, duration: kThemeAnimationDuration, curve: Curves.easeOut);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    pois = ref.watch(poiProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ListView.builder(
        cacheExtent: _fullItemHeight * 15,
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        itemCount: pois.length + 2,
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
          } else if (index == pois.length + 1) {
            // Spacer to allow last item to reach top
            return SizedBox(height: _fullItemHeight * 3);
          }

          final poi = pois[index - 1];

          return PoiTile(poi: poi, isExpanded: widget.isExpanded);
        },
      ),
    );
  }

  Future<void> _setSelected() async {
    if (widget.isExpanded) return;

    final offset = _scrollController.offset;
    var index = (offset / _fullItemHeight).round();
    if (index <= 1) index = 1;
    if (ref.read(selectedPoiProvider)?.id == pois[index - 1].id) {
      return; // Skip if the same item is selected
    }
    ref.read(selectedPoiProvider.notifier).setSelected(pois[index - 1]);
  }

  Future<void> _handleSnap() async {
    if (widget.isExpanded || _scrollController.position.isScrollingNotifier.value) return;

    final selectedPoi = ref.watch(selectedPoiProvider);
    if (selectedPoi == null) return;

    final poiIndex = pois.indexOf(selectedPoi);
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
  final Poi poi;
  final bool isExpanded;

  const PoiTile({super.key, required this.poi, required this.isExpanded});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final isTopItem = ref.watch(selectedPoiProvider)?.id == poi.id;

    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      height: isExpanded ? _itemHeight * 2 : _itemHeight,
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.symmetric(vertical: _itemPadding),
      decoration: BoxDecoration(
        color: isTopItem ? colorScheme.primaryContainer : colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          if (isTopItem)
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
              children: [
                AnimatedTitle(isExpanded: isExpanded, poi: poi),
                AnimatedDescription(isExpanded: isExpanded, poi: poi),
              ],
            ),
          ),
          AnimatedImage(isExpanded: isExpanded, poi: poi),
        ],
      ),
    );
  }
}

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({super.key, required this.isExpanded, required this.poi});

  final bool isExpanded;
  final Poi poi;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AnimatedAlign(
      alignment: isExpanded ? Alignment.centerLeft : Alignment.center,
      duration: kThemeAnimationDuration,
      curve: Curves.easeInOut,
      child: AnimatedDefaultTextStyle(
        duration: kThemeAnimationDuration,
        curve: Curves.easeInOut,
        style: TextStyle(
          color: colorScheme.onSurface, // Adjust if needed
          fontSize: isExpanded ? 16 : 20,
          fontWeight: isExpanded ? FontWeight.bold : FontWeight.w600,
        ),
        child: Text(poi.title),
      ),
    );
  }
}

class AnimatedDescription extends StatelessWidget {
  final bool isExpanded;
  final Poi poi;

  const AnimatedDescription({super.key, required this.isExpanded, required this.poi});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedCrossFade(
        crossFadeState: isExpanded ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        duration: kThemeAnimationDuration,
        firstChild: Text(
          poi.markdownLessData,
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
  final Poi poi;

  const AnimatedImage({super.key, required this.isExpanded, required this.poi});

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
              image: poi.imgUrl,
            ),
          ),
        );
      },
    );
  }
}
