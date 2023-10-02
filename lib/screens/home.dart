import 'package:favorite_places/models/places_model.dart';
import 'package:favorite_places/providers/places_list_provider.dart';
import 'package:favorite_places/screens/add_new_place.dart';
import 'package:favorite_places/widgets/place_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<PlacesModel> placesList = ref.watch(placesListProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('Places'),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (ctx) => const AddNewPlace()));
                },
                icon: const Icon(Icons.add)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: ListView.builder(
            itemCount: placesList.length,
            itemBuilder: (ctx, ix) {
              return Padding(
                padding: const EdgeInsets.all(6),
                child: PlaceListTile(
                  place: placesList[ix],
                ),
              );
            }),
      ),
    );
  }
}
