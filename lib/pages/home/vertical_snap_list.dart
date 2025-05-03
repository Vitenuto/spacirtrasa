import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/poi.dart';
import 'package:spacirtrasa/providers/selected_poi.dart';

import '../../providers/poi.dart';

class VerticalSnapList extends ConsumerStatefulWidget {
  const VerticalSnapList({super.key});

  @override
  ConsumerState<VerticalSnapList> createState() => _VerticalSnapListState();
}

class _VerticalSnapListState extends ConsumerState<VerticalSnapList> {
  final log = Logger();
  final ScrollController _scrollController = ScrollController();
  static const double _itemHeight = 50.0;
  static const _itemPadding = 4.0;

  double get _fullItemHeight => _itemHeight + (_itemPadding * 2);
  var _highlightedIndex = 1; // Start after the static title
  var isSnapping = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleHighlight);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.position.isScrollingNotifier.addListener(() {
        if (!_scrollController.position.isScrollingNotifier.value) _handleSnap();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final pois = ref.watch(poiProvider);

    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: ListView.builder(
        controller: _scrollController,
        padding: EdgeInsets.all(8),
        itemCount: pois.length + 2, // +2 for the title and spacer
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              alignment: Alignment.center,
              height: _itemHeight,
              child: Text('Interests around:', style: Theme.of(context).textTheme.titleMedium),
            );
          } else if (index == pois.length + 1) {
            // Spacer to allow last item to reach top
            return SizedBox(height: _fullItemHeight * 2);
          }

          final isTopItem = index == _highlightedIndex;
          if (isTopItem) {
            // Future(() => ref.read(selectedPoiProvider.notifier).setSelected(pois[index - 1]));
          }
          final item = pois[index - 1];

          return PoiTile(
            itemHeight: _itemHeight,
            itemPadding: _itemPadding,
            isTopItem: isTopItem,
            item: item,
          );
        },
      ),
    );
  }

  Future<void> _handleHighlight() async {
    final offset = _scrollController.offset;
    var index = (offset / _fullItemHeight).round();
    if (index != _highlightedIndex) {
      setState(() => _highlightedIndex = index == 0 ? 1 : index);
    }
  }

  Future<void> _handleSnap() async {
    final offset = _scrollController.offset;
    final index = (offset / _fullItemHeight).round();
    final snappedOffset = (index * _fullItemHeight).clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    );

    if (index == 0) return; // Do not snap to the title

    log.t(
      'Snapping to index: $index, offset: $offset, snappedOffset: $snappedOffset, maxScrollExtent: ${_scrollController.position.maxScrollExtent}',
    );
    await _scrollController.animateTo(
      snappedOffset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }
}

class PoiTile extends StatelessWidget {
  const PoiTile({
    super.key,
    required double itemHeight,
    required double itemPadding,
    required this.isTopItem,
    required this.item,
  }) : _itemHeight = itemHeight,
        _itemPadding = itemPadding;

  final double _itemHeight;
  final double _itemPadding;
  final bool isTopItem;
  final Poi item;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: _itemHeight,
      margin: EdgeInsets.symmetric(vertical: _itemPadding),
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
      child: Center(
        child: Text(
          item.title,
          style: TextStyle(
            color: isTopItem ? colorScheme.onPrimaryContainer : Colors.black87,
            fontWeight: isTopItem ? FontWeight.bold : FontWeight.normal,
            fontSize: isTopItem ? 18 : 16,
          ),
        ),
      ),
    );
  }
}
