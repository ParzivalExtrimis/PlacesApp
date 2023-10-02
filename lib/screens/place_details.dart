import 'package:favorite_places/models/places_model.dart';
import 'package:flutter/material.dart';

class PlaceDetails extends StatelessWidget {
  const PlaceDetails({super.key, required this.place});
  final PlacesModel place;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.name),
      ),
      body: Stack(
        children: [
          Image.file(
            place.picture,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          )
        ],
      ),
    );
  }
}
