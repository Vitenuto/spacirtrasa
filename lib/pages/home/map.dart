import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';
import 'package:spacirtrasa/providers/map_entity/position_permission_status.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/utils/utils.dart';
import 'package:spacirtrasa/widgets/map_skeleton.dart';

class MainMap extends ConsumerStatefulWidget {
  const MainMap({super.key});

  @override
  ConsumerState<MainMap> createState() => _MainMapState();
}

class _MainMapState extends ConsumerState<MainMap> with TickerProviderStateMixin {
  static final log = Logger();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  bool moveToUserPos = true;

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(positionPermissionStatusProvider, _onPermissionChanged);
    ref.listen(selectedPoiProvider, (_, selectedPoi) => _onSelectedPoi(selectedPoi));
    ref.listen(positionProvider, (_, next) => _onPositionChanged(next));

    return MapSkeleton(
      animatedMapController: _animatedMapController,
      mapChildLayers: _buildChildLayers(),
    );
  }

  void _onSelectedPoi(Poi? selectedPoi) {
    if (selectedPoi != null) {
      _animatedMapController.animateTo(
        duration: Duration(milliseconds: 2000),
        dest: LatLng(selectedPoi.location.latitude, selectedPoi.location.longitude),
      );
    }
  }

  List<Widget>? _buildChildLayers() {
    final currentLoc = ref.watch(positionProvider);
    final pinnedTrail = ref.watch(pinnedTrailProvider);

    return [
      MarkerLayer(
        markers: [
          if (currentLoc != null) buildUserLocationMarker(currentLoc),
          ..._buildPoiMarkers(currentLoc),
        ],
      ),
      if (pinnedTrail != null)
        PolylineLayer(
          polylines: [
            Polyline(
              points: pinnedTrail.path.toLatLngList(),
              strokeWidth: 6,
              color: Colors.blueAccent.withValues(alpha: 0.9),
            ),
          ],
        ),
    ];
  }

  void _onPermissionChanged(previous, next) {
    moveToUserPos = next == ServiceStatus.enabled;
  }

  void _onPositionChanged(Position? next) {
    if (moveToUserPos && next != null) {
      moveToUserPos = false;

      final userPos = LatLng(next.latitude, next.longitude);
      if (!defaultBounds.contains(userPos)) {
        log.w('User position: $userPos is outside of default bounds: $defaultBounds');
        Fluttertoast.showToast(
          toastLength: Toast.LENGTH_LONG,
          msg: 'You are outside of the usable area, move closer to Ořechov u Brna',
        );
        return;
      }

      _animatedMapController.animateTo(duration: Duration(milliseconds: 2000), dest: userPos);
    }
  }

  List<Marker> _buildPoiMarkers(Position? currentLoc) {
    final pois = ref.watch(poiProvider);
    final selectedPoi = ref.watch(selectedPoiProvider);
    return pois.map((poi) {
      final isSelected = selectedPoi?.id == poi.id;

      return Marker(
        point: LatLng(poi.location.latitude, poi.location.longitude),
        child: Icon(
          Icons.location_on,
          color: isSelected ? Colors.red : Colors.grey,
          size: isSelected ? 30 : 20,
        ),
      );
    }).toList();
  }
}
