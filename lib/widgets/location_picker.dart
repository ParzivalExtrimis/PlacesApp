import 'package:favorite_places/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationPicker extends StatefulWidget {
  const LocationPicker({super.key, required this.onLocationPicked});

  final void Function(Map<String, double>) onLocationPicked;

  @override
  State<LocationPicker> createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  LocationData? _pickedLocation;
  bool fetchingLocation = false;

  void getCurrentLocation() async {
    setState(() {
      fetchingLocation = true;
    });

    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData? locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    try {
      locationData = await location.getLocation();
    } on Exception {
      locationData = null;
    }

    if (locationData == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Something went wrong. Map could not be loaded'),
          ),
        );
      }
      return;
    }

    setState(() {
      _pickedLocation = locationData;
      fetchingLocation = false;
      widget.onLocationPicked({
        'latitude': _pickedLocation!.latitude!,
        'longitude': _pickedLocation!.longitude!
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          decoration: ShapeDecoration(
            shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(6),
                side: BorderSide(
                    width: 0.25,
                    color: Theme.of(context).colorScheme.secondary)),
          ),
          child: _pickedLocation == null
              ? Center(
                  child: Text(
                    'No location selected',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.w200,
                        ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: MapWidget(initialLocation: _pickedLocation!),
                  ),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: null,
                icon: const Icon(Icons.map_rounded),
                label: const Text('Set on map')),
            TextButton.icon(
                onPressed: getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('Use current location')),
          ],
        )
      ],
    );
  }
}
