
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
}
