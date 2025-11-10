import 'package:flutter/material.dart';
import 'package:spacirtrasa/utils/utils.dart';

Future<void> handleSnap(ScrollController scrollCtrl, int listIndex) async {
  final snappedOffset = (listIndex * fullItemHeight).clamp(
    0.0,
    scrollCtrl.position.maxScrollExtent,
  );

  if (snappedOffset == scrollCtrl.offset) return; // Skip snapping to the same item

  await scrollCtrl.animateTo(
    snappedOffset,
    duration: kThemeAnimationDuration,
    curve: Curves.easeOut,
  );
}
