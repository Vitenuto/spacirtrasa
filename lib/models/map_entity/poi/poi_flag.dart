
import 'package:flutter/material.dart';

enum PoiFlag { monument, nature, food, transportation }

extension PoiFlagExtension on PoiFlag {
  Icon get icon {
    switch (this) {
      case PoiFlag.monument:
        return const Icon(Icons.account_balance);
      case PoiFlag.nature:
        return const Icon(Icons.nature);
      case PoiFlag.food:
        return const Icon(Icons.restaurant);
      case PoiFlag.transportation:
        return const Icon(Icons.directions_bus);
    }
  }

  Color get color {
    switch (this) {
      case PoiFlag.monument:
        return Color(0x00722f37);
      case PoiFlag.nature:
        return Colors.green;
      case PoiFlag.food:
        return Colors.purpleAccent;
      case PoiFlag.transportation:
        return Colors.blue;
    }
  }
}
