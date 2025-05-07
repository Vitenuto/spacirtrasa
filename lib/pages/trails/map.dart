import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spacirtrasa/providers/map_entity/trail/selected_trail.dart';
import 'package:spacirtrasa/utils/converters.dart';
import 'package:spacirtrasa/widgets/map_skeleton.dart';

class MainMap extends ConsumerStatefulWidget {
  const MainMap({super.key});

  @override
  ConsumerState<MainMap> createState() => _MainMapState();
}

class _MainMapState extends ConsumerState<MainMap> with TickerProviderStateMixin {
  late final _animatedMapController = AnimatedMapController(vsync: this);

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(selectedTrailProvider, (_, selectedTrail) {
      if (selectedTrail != null) {
        final latLngList = selectedTrail.path.toLatLngList();
        _animatedMapController.animatedFitCamera(
          cameraFit: CameraFit.coordinates(
            coordinates: latLngList,
            padding: EdgeInsets.all(16).copyWith(bottom: 250),
          ),
        );
      }
    });

    return MapSkeleton(
      animatedMapController: _animatedMapController,
      mapChildLayers: _buildChildLayers(),
    );
  }

  List<PolylineLayer>? _buildChildLayers() {
    final selectedTrail = ref.watch(selectedTrailProvider);
    if (selectedTrail == null) return null;

    final latLngList = selectedTrail.path.toLatLngList();
    return [
      PolylineLayer(
        polylines: [
          Polyline(
            points: latLngList,
            strokeWidth: 6,
            color: Colors.blueAccent.withValues(alpha: 0.9),
          ),
        ],
      ),
    ];
  }
}
