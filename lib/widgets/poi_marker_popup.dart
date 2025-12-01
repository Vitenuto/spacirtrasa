import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi_flag.dart';
import 'package:spacirtrasa/pages/pois/poi_detail.dart';

class PoiMarkerPopup extends StatelessWidget {
  final Poi poi;

  const PoiMarkerPopup({super.key, required this.poi});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(poi.imgUrl, width: 200),
              ),
              Text(
                poi.titleLocalized,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(poi.markdownLessDataLocalized, maxLines: 3, overflow: TextOverflow.ellipsis),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton.filledTonal(
                    icon: Icon(Icons.directions_outlined),
                    tooltip: 'poi-marker.directions'.tr(),
                    onPressed:
                        () => MapsLauncher.launchCoordinates(
                          poi.location.latitude,
                          poi.location.longitude,
                          poi.titleLocalized,
                        ),
                  ),
                  IconButton.filledTonal(
                    icon: Icon(Icons.info_outlined),
                    tooltip: 'poi-marker.info'.tr(),
                    onPressed: () => showPoiDetail(context, poi),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PoiMarker extends Marker {
  final Poi poi;
  final bool isSelected;

  PoiMarker({required this.poi, required this.isSelected})
    : super(
        alignment: Alignment.topCenter,
        rotate: true,
        point: LatLng(poi.location.latitude, poi.location.longitude),
        child: SizedBox.expand(
          child: FittedBox(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  Icons.location_on,
                  size: 60,
                  color: isSelected ? Colors.red.withAlpha(220) : poi.flag.color.withAlpha(220),
                  fill: 1,
                ),
                Positioned(
                  top: 8,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15,
                    child: poi.flag.icon,
                  ),
                ),
              ],
            ),
          ),
        ),
        width: isSelected ? 60 : 45,
        height: isSelected ? 60 : 45,
      );
}
