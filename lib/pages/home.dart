import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(51.509364, -0.128928), // Center the map over London
        initialZoom: 1,
      ),
      children: [
        TileLayer( // Bring your own tiles
          urlTemplate: 'https://api.mapy.cz/v1/maptiles/basic/256@2x/{z}/{x}/{y}?apikey=${dotenv.env['MAP_API_KEY']}', // For demonstration only
          userAgentPackageName: 'com.nakladal.spacirtrasa', // Add your app identifier
          // And many more recommended properties!
        ),
        RichAttributionWidget( // Include a stylish prebuilt attribution widget that meets all requirments
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: () => SnackBar(content: Text("Bla")), // (external)
            ),
            // Also add images...
          ],
        ),
      ],
    );
  }
}
