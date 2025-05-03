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
          return Stack(
            clipBehavior: Clip.none, // allow overflow for the button
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorScheme.primaryContainer.withAlpha(230),
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: VerticalSnapList(),
              ),

              ExpandButton(),
            ],
          );
        },
      ),
    );
  }
}

class ExpandButton extends StatelessWidget {
  const ExpandButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: -12,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: () {
            // Example action: Expand sheet to full height
            // sheetController.animateTo(...) if using a controller
          },
          child: Container(
            width: 48,
            height: 24,
            decoration: BoxDecoration(
              color: colorScheme.primary,
              borderRadius: BorderRadius.circular(12), // Rounded rectangle
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.keyboard_arrow_up, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
