import 'dart:io';

import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_file_store/dio_cache_interceptor_file_store.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:flutter_map_cache/flutter_map_cache.dart';
import 'package:flutter_map_compass/flutter_map_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spacirtrasa/generated/assets.gen.dart';
import 'package:spacirtrasa/providers/map_entity/position.dart';
import 'package:spacirtrasa/providers/map_entity/position_permission_status.dart';
import 'package:spacirtrasa/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class MainMap extends ConsumerStatefulWidget {
  const MainMap({super.key});

  @override
  ConsumerState<MainMap> createState() => _MainMapState();
}

class _MainMapState extends ConsumerState<MainMap> with TickerProviderStateMixin {
  static final log = Logger();
  final mapTileUrl =
      "https://api.mapy.cz/v1/maptiles/basic/256@2x/{z}/{x}/{y}?apikey=${dotenv.env['MAP_API_KEY']}";
  final mapContributionUrl = "https://api.mapy.cz/copyright";
  final mapUrl = "https://mapy.cz/";
  final Future<CacheStore> cacheStoreFuture = _getCacheStore();

  late final _animatedMapController = AnimatedMapController(vsync: this);
  ProviderSubscription<Position?>? _onPositionChangedSub;

  @override
  void initState() {
    super.initState();
    _handleMoveToCurrentUserPos();
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

  @override
  void dispose() {
    _animatedMapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentLoc = ref.watch(positionProvider);
    ref.listen(positionPermissionStatusProvider, _onPermissionChanged);

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
            mapController: _animatedMapController.mapController,
            children: [
              TileLayer(
                urlTemplate: mapTileUrl,
                tileProvider: CachedTileProvider(
                  // use the store for your CachedTileProvider instance
                  store: cacheStore,
                ),
              ),
              MarkerLayer(markers: [if (currentLoc != null) _buildUserLocationMarker(currentLoc)]),
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

  Future<void> _launchUrl(final String url) async {
    final Uri uri = Uri.parse(url);

    if (!await launchUrl(uri)) {
      throw Exception('Could not launch $uri');
    }
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

  static Future<CacheStore> _getCacheStore() async {
    final dir = await getApplicationCacheDirectory();
    return FileCacheStore('${dir.path}${Platform.pathSeparator}MapTiles');
  }
}
