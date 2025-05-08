import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

const itemListHeight = 45.0;
const itemListPadding = 4.0;
const double kDefaultPadding = 12;
final defaultPosition = LatLng(49.1118439, 16.5184100); // OÚ Ořechova u Brna
final defaultBounds = LatLngBounds(
  // Bounds around Ořechov u Brna
  LatLng(49.05, 16.46),
  LatLng(49.2557, 16.6954),
);