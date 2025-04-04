import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_compass/flutter_map_compass.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../generated/assets.gen.dart';

class MainMap extends StatefulWidget {
  const MainMap({super.key});

  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  final _mapTileUrl =
      "https://api.mapy.cz/v1/maptiles/basic/256@2x/{z}/{x}/{y}?apikey=${dotenv
      .env['MAP_API_KEY']}";
  final _mapContributionUrl = "https://api.mapy.cz/copyright";
  final _mapUrl = "https://mapy.cz/";

  // create the cache store as a field variable
  final Future<CacheStore> _cacheStoreFuture = _getCacheStore();

  /// Get the CacheStore as a Future. This method needs to be static so that it
  /// can be used to initialize a field variable.
  static Future<CacheStore> _getCacheStore() async {
    final dir = await getTemporaryDirectory();
    return FileCacheStore('${dir.path}${Platform.pathSeparator}MapTiles');
  }

  @override
  Widget build(BuildContext context) {
    // show a loading screen when _cacheStore hasn't been set yet
    return FutureBuilder<CacheStore>(
      future: _cacheStoreFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final cacheStore = snapshot.data!;
          return FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(49.1118439, 16.5184100),
              initialZoom: 15,
              minZoom: 13,
              maxZoom: 18,
              keepAlive: true,
              interactionOptions: const InteractionOptions(enableMultiFingerGestureRace: true),
              cameraConstraint: CameraConstraint.containCenter(
                bounds: LatLngBounds(
                  LatLng(49.05, 16.46), // Southwest corner
                  LatLng(49.15, 16.56), // Northeast corner
                ),
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: _mapTileUrl,
                tileProvider: CachedTileProvider(
                  // use the store for your CachedTileProvider instance
                  store: cacheStore,
                ),
              ),
              const MapCompass.cupertino(hideIfRotatedNorth: true),
              LogoSourceAttribution(
                height: 28,
                Assets.images.mapyLogo.image(),
                onTap: () => _launchUrl(_mapUrl),
              ),
              _buildTextAttribution(),
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

  Future<void> _launchUrl(final String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
  }

  Align _buildTextAttribution() {
    return Align(
      alignment: Alignment.topRight,
      child: ColoredBox(
        color: Theme
            .of(context)
            .colorScheme
            .surface,
        child: GestureDetector(
          onTap: () => _launchUrl(_mapContributionUrl),
          child: Padding(
            padding: const EdgeInsets.all(3),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('© Seznam.cz a.s. a další')
              ],
            ),
          ),
        ),
      ),
    );
  }
}
