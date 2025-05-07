import 'package:flutter/material.dart';

enum TrailFlags { stroller, tourist, hill }

extension TrailFlagsExtension on TrailFlags {
  Icon get icon {
    switch (this) {
      case TrailFlags.stroller:
        return const Icon(Icons.stroller);
      case TrailFlags.tourist:
        return const Icon(Icons.hiking);
      case TrailFlags.hill:
        return const Icon(Icons.landscape);
    }
  }
}
