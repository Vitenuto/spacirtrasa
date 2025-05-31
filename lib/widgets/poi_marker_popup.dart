import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:spacirtrasa/models/map_entity/poi/poi.dart';
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
                poi.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(poi.markdownLessData, maxLines: 3, overflow: TextOverflow.ellipsis),
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
                          poi.title,
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
            child: Icon(
              Icons.location_on,
              color: isSelected ? Colors.red.withAlpha(220) : Colors.blueGrey.withAlpha(220),
            ),
          ),
        ),
        width: isSelected ? 60 : 45,
        height: isSelected ? 60 : 45,
      );
}
