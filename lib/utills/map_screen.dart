import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapWidget extends StatelessWidget {
  final LatLng location;

  MapWidget({required this.location});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: location,

        // zoom: 25,
      ),
      nonRotatedChildren: [
        // RichAttributionWidget(
        //   popupInitialDisplayDuration: const Duration(seconds: 5),
        //   attributions: [
        //     TextSourceAttribution(
        //       'Sentinel-2 cloudless - https://s2maps.eu by EOX IT Services GmbH',
        //       onTap: () => launchUrl(
        //         Uri.parse('https://s2maps.eu '),
        //       ),
        //     ),
        //     const TextSourceAttribution(
        //       'Modified Copernicus Sentinel data 2021',
        //     ),
        //     TextSourceAttribution(
        //       'Rendering: EOX::Maps',
        //       onTap: () => launchUrl(
        //         Uri.parse('https://maps.eox.at/'),
        //       ),
        //     ),
        //   ],
        // ),
      ],
      children: [
        TileLayer(
          wmsOptions: WMSTileLayerOptions(
            baseUrl: 'https://{s}.s2maps-tiles.eu/wms/?',
            layers: ['s2cloudless-2021_3857'],
          ),
          subdomains: const ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
          // userAgentPackageName: 'dev.fleaflet.flutter_map.example',
        ),
        MarkerLayer(
          markers: [
            Marker(
              width: 80.0,
              height: 80.0,
              point: location,
              builder: (context) => const Icon(
                Icons.location_on,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ],
    );
  }
}




/**FlutterMap(
      options: MapOptions(
        center: location,
        zoom: 13,
      ),
      children: [
        TileLayer(
          wmsOptions: WMSTileLayerOptions(
            baseUrl: 'https://{s}.s2maps-tiles.eu/wms/?',
            layers: ['s2cloudless-2021_3857'],
          ),
          subdomains: const ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'],
        ),
        
      ],
    ); */



/**
            */
