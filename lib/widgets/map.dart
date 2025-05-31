import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';
import 'package:spacirtrasa/providers/map_entity/position_permission_status.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/utils/utils.dart';
import 'package:spacirtrasa/widgets/map_skeleton.dart';

class MainMap extends ConsumerStatefulWidget {
  final bool showSelectedTrail;

  const MainMap({this.showSelectedTrail = false, super.key});

  @override
  ConsumerState<MainMap> createState() => _MainMapState();
}

class _MainMapState extends ConsumerState<MainMap> with TickerProviderStateMixin {
  final log = Logger();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  bool moveToUserPos = false;

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedTrailProvider, (_, selectedTrail) => _onSelectedTrail(selectedTrail));
    ref.listen(positionPermissionStatusProvider, _onPermissionChanged);
    ref.listen(selectedPoiProvider, (_, selectedPoi) => _onSelectedPoi(selectedPoi));
    ref.listen(positionProvider, (_, next) => _onPositionChanged(next));

    return MapSkeleton(
      animatedMapController: _animatedMapController,
      mapChildLayers: [PolylineLayer(polylines: _buildPolylines()), _buildMarkerLayer()],
    );
  }

  void _onSelectedTrail(Trail? selectedTrail) {
    if (selectedTrail != null) {
      final latLngList = selectedTrail.path.toLatLngList();
      _animatedMapController.animatedFitCamera(
        cameraFit: CameraFit.coordinates(
          coordinates: latLngList,
          padding: EdgeInsets.all(16).copyWith(bottom: 250),
        ),
      );
    }
  }

  void _onSelectedPoi(Poi? selectedPoi) {
    if (selectedPoi != null) {
      _animatedMapController.animateTo(
        duration: Duration(milliseconds: 2000),
        dest: LatLng(selectedPoi.location.latitude, selectedPoi.location.longitude),
      );
    }
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

  MarkerLayer _buildMarkerLayer() {
    final currentLoc = ref.watch(positionProvider);

    return MarkerLayer(
      markers: [
        if (currentLoc != null) buildUserLocationMarker(currentLoc),
        ..._buildPoiMarkers(currentLoc),
      ],
    );
  }

  List<Polyline> _buildPolylines() {
    List<Polyline> polylines = [];

    final pinnedTrail = ref.watch(pinnedTrailProvider);
    if (pinnedTrail != null) {
      polylines.add(
        Polyline(
          points: pinnedTrail.path.toLatLngList(),
          strokeWidth: 6,
          color: Colors.blueAccent.withValues(alpha: 0.9),
        ),
      );
    }

    final trails = ref.watch(trailProvider).toList();
    trails.remove(pinnedTrail);

    final selectedTrail = ref.watch(selectedTrailProvider);
    if (widget.showSelectedTrail && selectedTrail != null && selectedTrail != pinnedTrail) {
      polylines.add(
        Polyline(
          points: selectedTrail.path.toLatLngList(),
          strokeWidth: 6,
          color: selectedTrail.color.withValues(alpha: 0.9),
        ),
      );
      trails.remove(selectedTrail);
    }


    log.t("Remaining trail length: ${trails.length}");
    for (final trail in trails) {
      polylines.add(
        Polyline(
          points: trail.path.toLatLngList(),
          strokeWidth: 10,
          useStrokeWidthInMeter: true,
          color: trail.color.withValues(alpha: 0.5),
          pattern: StrokePattern.dashed(segments: [30,40]),
        ),
      );
    }

    return polylines.reversed.toList(); // Reverse to show pinned and selected trails on top
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
          size: isSelected ? 45 : 35,
        ),
      );
    }).toList();
  }
}
