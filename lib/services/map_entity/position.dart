import 'package:geolocator/geolocator.dart';
import 'package:spacirtrasa/utils/utils.dart';

class PositionService {
  static const String _kLocationServicesDisabledMessage = 'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Location permission denied.';
  static const String _kPermissionDeniedForeverMessage = 'Location permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Location permission granted.';
  static final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  // Need to check for permissions before, otherwise exception may be thrown
  static Stream<Position> getPositionStream() => Geolocator.getPositionStream();

  static Future<bool> checkPermissions() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      logger.w(_kLocationServicesDisabledMessage);
      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        logger.w(_kPermissionDeniedMessage);
        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      logger.w(_kPermissionDeniedForeverMessage);
      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    logger.i(_kPermissionGrantedMessage);
    return true;
  }
}

extension PositionComparison on Position {
  bool isEqual(Position? other, {double accuracyInMeters = 1.0}) {
    if (other == null) return false;

    final distance = Geolocator.distanceBetween(
      latitude,
      longitude,
      other.latitude,
      other.longitude,
    );
    return distance <= accuracyInMeters;
  }

  bool isNotEqual(Position? other, {double accuracyInMeters = 1.0}) {
    return !isEqual(other, accuracyInMeters: accuracyInMeters);
  }
}
