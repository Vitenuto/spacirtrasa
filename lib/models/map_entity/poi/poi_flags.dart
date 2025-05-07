
import 'package:flutter/material.dart';

enum PoiFlags { monument, nature, food, transportation }

extension TrailFlagsExtension on PoiFlags {
  Icon get icon {
    switch (this) {
      case PoiFlags.monument:
        return const Icon(Icons.account_balance);
      case PoiFlags.nature:
        return const Icon(Icons.nature);
      case PoiFlags.food:
        return const Icon(Icons.restaurant);
      case PoiFlags.transportation:
        return const Icon(Icons.directions_bus);
    }
  }
}
