import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';
import 'package:spacirtrasa/providers/map_entity/position_permission_status.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/widgets/map_skeleton.dart';

class MainMap extends ConsumerStatefulWidget {
  const MainMap({super.key});

  @override
  ConsumerState<MainMap> createState() => _MainMapState();
}

class _MainMapState extends ConsumerState<MainMap> with TickerProviderStateMixin {
  static final log = Logger();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  ProviderSubscription<Position?>? _onPositionChangedSub;

  @override
  void initState() {
    super.initState();
    _handleMoveToCurrentUserPos();
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(positionPermissionStatusProvider, _onPermissionChanged);

    return MapSkeleton(
      animatedMapController: _animatedMapController,
      mapChildLayers: _buildChildLayers(),
    );
  }

  List<Widget>? _buildChildLayers() {
    final currentLoc = ref.watch(positionProvider);
    final pinnedTrail = ref.watch(pinnedTrailProvider);

    return [
      MarkerLayer(
        markers: [
          if (currentLoc != null) _buildUserLocationMarker(currentLoc),
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

  Marker _buildUserLocationMarker(final Position currentLoc) {
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

  void _onPermissionChanged(previous, next) {
    if (next != previous && next == ServiceStatus.enabled) _handleMoveToCurrentUserPos();
  }

  void _handleMoveToCurrentUserPos() {
    if (_onPositionChangedSub?.closed == false) {
      log.w("handleMoveToCurrentUserPos called when onPositionChanged is already listening");
      return;
    }

    log.i("Moving camera to current user's position, after location would be ready");
    _onPositionChangedSub = ref.listenManual(positionProvider, (previous, next) {
      if (next != null) {
        _animatedMapController.animateTo(
          duration: Duration(milliseconds: 2000),
          dest: LatLng(next.latitude, next.longitude),
        );
        _onPositionChangedSub
            ?.close(); // otherwise would be closed automatically when widget is disposed
      }
    });
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
