import 'package:flutter/material.dart';

enum TrailFlag { stroller, tourist, hill }

extension TrailFlagExtension on TrailFlag {
  Icon get icon {
    switch (this) {
      case TrailFlag.stroller:
        return const Icon(Icons.stroller);
      case TrailFlag.tourist:
        return const Icon(Icons.hiking);
      case TrailFlag.hill:
        return const Icon(Icons.landscape);
    }
  }
}
