import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class MapWidget extends StatelessWidget {
  MapWidget({super.key, required this.initialLocation});
  final LocationData initialLocation;
  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FlutterMap(
          mapController: mapController,
          options: MapOptions(
            keepAlive: true,
            center:
                LatLng(initialLocation.latitude!, initialLocation.longitude!),
            interactiveFlags: InteractiveFlag.pinchZoom +
                InteractiveFlag.doubleTapZoom +
                InteractiveFlag.drag,
            zoom: 13,
            maxZoom: 15,
            minZoom: 8,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.hegde.aryan.favourite-places',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: LatLng(
                      initialLocation.latitude!, initialLocation.longitude!),
                  width: 80,
                  height: 80,
                  builder: (context) => const Icon(
                    Icons.location_on,
                    color: Color.fromARGB(255, 219, 39, 27),
                  ),
                ),
              ],
            ),
          ],
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4)),
                  color: Theme.of(context)
                      .colorScheme
                      .background
                      .withOpacity(0.4)),
              child: IconButton(
                onPressed: () {
                  mapController.move(
                      LatLng(initialLocation.latitude!,
                          initialLocation.longitude!),
                      13);
                },
                icon: const Icon(
                  Icons.gps_fixed_sharp,
                  size: 23,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
