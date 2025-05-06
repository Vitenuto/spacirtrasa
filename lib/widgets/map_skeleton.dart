import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_compass/flutter_map_compass.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MapSkeleton extends StatefulWidget {
  final AnimatedMapController? _animatedMapController;
  final List<Widget>? _mapChildLayer;

  const MapSkeleton({
    super.key,
    AnimatedMapController? animatedMapController,
    List<Widget>? mapChildLayers,
  }) : _animatedMapController = animatedMapController,
       _mapChildLayer = mapChildLayers;

  @override
  State<MapSkeleton> createState() => _MapSkeletonState();
}

class _MapSkeletonState extends State<MapSkeleton> {
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
              minZoom: 13,
              maxZoom: 18,
              keepAlive: true,
              interactionOptions: const InteractionOptions(enableMultiFingerGestureRace: true),
              cameraConstraint: CameraConstraint.containCenter(bounds: defaultBounds),
            ),
            mapController: widget._animatedMapController?.mapController,
            children: [
              TileLayer(
                urlTemplate: mapTileUrl,
                tileProvider: CachedTileProvider(
                  // use the store for your CachedTileProvider instance
                  store: cacheStore,
                ),
              ),
              if (widget._mapChildLayer != null) ...widget._mapChildLayer!,
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
        onTap: () => _launchUrl(mapUrl),
      ),
      Align(
        alignment: Alignment.topRight,
        child: ColoredBox(
          color: Theme.of(context).colorScheme.surface,
          child: GestureDetector(
            onTap: () => _launchUrl(mapContributionUrl),
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [const Text('© Seznam.cz a.s. a další')],
              ),
            ),
          ),
        ),
      ),
    ];
  }

  Future<void> _launchUrl(final String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  static Future<CacheStore> _getCacheStore() async {
    final dir = await getApplicationCacheDirectory();
    return FileCacheStore('${dir.path}${Platform.pathSeparator}MapTiles');
  }
}
