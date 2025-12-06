import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';

import 'constants.dart';

Logger get logger => Log.instance;

class Log extends Logger {
  Log._()
    : super(
        level: Level.info,
        printer: PrettyPrinter(
          methodCount: 1,
          errorMethodCount: 8,
          lineLength: 120,
          colors: true,
          printEmojis: true,
        ),
      );
  static final instance = Log._();
}

void showFullDialog(BuildContext context, Widget child) {
  showDialog<String>(
    context: context,
    builder: (BuildContext context) => Dialog.fullscreen(child: child),
  );
}

double get fullItemHeight => itemListHeight + (itemListPadding * 2);

Marker buildUserLocationMarker(Position currentLoc) {
  return Marker(
    point: LatLng(currentLoc.latitude, currentLoc.longitude),
    width: 20,
    height: 20,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue,
        border: Border.all(color: Colors.white, width: 3),
      ),
    ),
  );
}
