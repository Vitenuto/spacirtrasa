import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_compass/flutter_map_compass.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../providers/map_entity/is_following.dart';

class MapSkeleton extends ConsumerStatefulWidget {
  final AnimatedMapController? animatedMapController;
  final List<Widget> childLayers;

  const MapSkeleton({required this.animatedMapController, required this.childLayers, super.key});

  @override
  ConsumerState<MapSkeleton> createState() => _MapSkeletonState();
}

class _MapSkeletonState extends ConsumerState<MapSkeleton> {
  final mapTileUrl =
      "https://api.mapy.cz/v1/maptiles/basic/256@2x/{z}/{x}/{y}?apikey=${dotenv.env['MAP_API_KEY']}";
  final mapContributionUrl = "https://api.mapy.cz/copyright";
  final mapUrl = "https://mapy.cz/";
  final Future<CacheStore> cacheStoreFuture = _getCacheStore();

  @override
  Widget build(BuildContext context) {
    // show a loading screen when _cacheStore hasn't been set yet
    return FutureBuilder<CacheStore>(
      future: cacheStoreFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cacheStore = snapshot.data!;
          return FlutterMap(
            options: MapOptions(
              initialCenter: defaultPosition,
              initialZoom: 15,
              minZoom: 10,
              maxZoom: 18,
              keepAlive: true,
              interactionOptions: const InteractionOptions(enableMultiFingerGestureRace: true),
              cameraConstraint: CameraConstraint.containCenter(bounds: defaultBounds),
              onPositionChanged: (MapCamera camera, bool hasGesture) {
                if (hasGesture) {
                  ref.read(isFollowingProvider.notifier).setIsFollowing(AlignOnUpdate.never);
                }
              },
            ),
            mapController: widget.animatedMapController?.mapController,
            children: [
              TileLayer(
                urlTemplate: mapTileUrl,
                tileProvider: CachedTileProvider(
                  // use the store for your CachedTileProvider instance
                  store: cacheStore,
                ),
              ),
              ...widget.childLayers,
              const MapCompass.cupertino(hideIfRotatedNorth: true),
              ..._buildContributions(),
            ],
          );
        }
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  List<Widget> _buildContributions() {
    return [
      LogoSourceAttribution(
        height: 28,
        Assets.images.mapyLogo.image(),
        onTap: () => launchUrl(Uri.parse(mapUrl)),
      ),
      Align(
        alignment: Alignment.topRight,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: GestureDetector(
            onTap: () => launchUrl(Uri.parse(mapContributionUrl)),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [Text('mapy.cz-contributions'.tr())],
              ),
            ),
          ),
        ),
      ),
    ];
  }

  static Future<CacheStore> _getCacheStore() async {
    final dir = await getApplicationCacheDirectory();
    return FileCacheStore('${dir.path}${Platform.pathSeparator}MapTiles');
  }
}
