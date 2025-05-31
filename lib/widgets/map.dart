import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/trail/trail.dart';
import 'package:spacirtrasa/providers/map_entity/is_following.dart';
import 'package:spacirtrasa/providers/map_entity/poi/poi.dart';
import 'package:spacirtrasa/providers/map_entity/poi/selected_poi.dart';
import 'package:spacirtrasa/providers/map_entity/position_permission_status.dart';
import 'package:spacirtrasa/providers/map_entity/trail/pinned_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/providers/map_entity/trail/trail.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/widgets/map_skeleton.dart';
import 'package:spacirtrasa/widgets/poi_marker_popup.dart';

class MainMap extends ConsumerStatefulWidget {
  final bool showSelectedTrail;

  const MainMap({this.showSelectedTrail = false, super.key});

  @override
  ConsumerState<MainMap> createState() => _MainMapState();
}

class _MainMapState extends ConsumerState<MainMap> with TickerProviderStateMixin {
  final log = Logger();
  final PopupController _popupLayerController = PopupController();
  late final _animatedMapController = AnimatedMapController(vsync: this);
  late final StreamController<double?> _alignPositionStreamController;

  @override
  void initState() {
    super.initState();
    _alignPositionStreamController = StreamController<double?>();
  }

  @override
  void dispose() {
    _animatedMapController.dispose();
    _alignPositionStreamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedTrailProvider, (_, selectedTrail) => _onSelectedTrail(selectedTrail));
    ref.listen(selectedPoiProvider, (_, selectedPoi) => _onSelectedPoi(selectedPoi));
    final permissionStatus = ref.watch(positionPermissionStatusProvider);
    final isFollowing = ref.watch(isFollowingProvider);

    return MapSkeleton(
      animatedMapController: _animatedMapController,
      onMapTap: _popupLayerController.hideAllPopups,
      childLayers: [
        PolylineLayer(polylines: _buildPolylines()),
        CurrentLocationLayer(
          alignPositionStream: _alignPositionStreamController.stream,
          alignPositionOnUpdate: isFollowing,
        ),
        _buildMarkerLayer(),
        if (ServiceStatus.enabled == permissionStatus) _buildLocationButton(context),
      ],
    );
  }

  PopupMarkerLayer _buildMarkerLayer() {
    return PopupMarkerLayer(
      options: PopupMarkerLayerOptions(
        markers: _buildMarkers(),
        popupController: _popupLayerController,
        popupDisplayOptions: PopupDisplayOptions(
          builder: (_, Marker marker) {
            if (marker is PoiMarker) {
              return PoiMarkerPopup(poi: marker.poi);
            }
            return const Card();
          },
        ),
      ),
    );
  }

  Align _buildLocationButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isFollowing = ref.watch(isFollowingProvider);

    return Align(
      alignment: Alignment(0.95, expandableSheetSize - 0.05),
      child: FloatingActionButton(
        onPressed: () {
          // Align the location marker to the center of the map widget
          // on location update until user interact with the map.
          ref.read(isFollowingProvider.notifier).setIsFollowing(AlignOnUpdate.always);

          // Align the location marker to the center of the map widget
          // and zoom the map to level 18.
          _alignPositionStreamController.add(18);
        },
        backgroundColor: colorScheme.primary.withAlpha(200),
        child: Icon(
          AlignOnUpdate.always == isFollowing ? Icons.my_location : Icons.location_searching,
          color: colorScheme.onPrimary,
        ),
      ),
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

  List<Polyline> _buildPolylines() {
    List<Polyline> polylines = [];

    final pinnedTrail = ref.watch(pinnedTrailProvider);
    if (pinnedTrail != null) {
      polylines.add(
        Polyline(
          points: pinnedTrail.path.toLatLngList(),
          strokeWidth: 8,
          color: Colors.blueAccent.withAlpha(220),
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
          strokeWidth: 8,
          color: selectedTrail.flagColor.withAlpha(220),
        ),
      );
      trails.remove(selectedTrail);
    }

    for (final trail in trails) {
      polylines.add(
        Polyline(
          points: trail.path.toLatLngList(),
          strokeWidth: 5,
          useStrokeWidthInMeter: true,
          color: trail.flagColor.withAlpha(120),
          pattern: StrokePattern.dashed(segments: [30, 40]),
        ),
      );
    }

    return polylines.reversed.toList(); // Reverse to show pinned and selected trails on top
  }

  List<PoiMarker> _buildMarkers() {
    final pois = ref.watch(poiProvider);
    final selectedPoi = ref.watch(selectedPoiProvider);
    return pois.map((poi) {
      final isSelected = selectedPoi?.id == poi.id;

      return PoiMarker(poi: poi, isSelected: isSelected);
    }).toList();
  }
}
