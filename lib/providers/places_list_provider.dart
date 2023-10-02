import 'package:favorite_places/models/places_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final placesListProvider =
    StateNotifierProvider<PlacesListNotifier, List<PlacesModel>>(
        (ref) => PlacesListNotifier());

class PlacesListNotifier extends StateNotifier<List<PlacesModel>> {
  PlacesListNotifier() : super([]);

  void append(PlacesModel newPlace) {
    state = [...state, newPlace];
  }

  void delete(String placeId) {
    state = state.where((place) => place.id != placeId).toList();
  }
}
