import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/pages/home/vertical_snap_list.dart';

final _minSheetSize = 0.1;
final _maxSheetSize = 1.0;

class DragScrollSheet extends ConsumerStatefulWidget {
  const DragScrollSheet({super.key});

  @override
  ConsumerState<DragScrollSheet> createState() => _DragScrollSheetState();
}

class _DragScrollSheetState extends ConsumerState<DragScrollSheet> {
  final log = Logger();

  final double _sheetPosition = 0.3;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: DraggableScrollableSheet(
        initialChildSize: _sheetPosition,
        minChildSize: _minSheetSize,
        maxChildSize: _maxSheetSize,
        builder: (BuildContext context, ScrollController scrollController) {
          return Container(
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer.withValues(alpha: 0.9),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: VerticalSnapList(),
          );
        },
      ),
    );
  }
}
