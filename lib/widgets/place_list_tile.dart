import 'package:favorite_places/models/places_model.dart';
import 'package:favorite_places/providers/places_list_provider.dart';
import 'package:favorite_places/screens/place_details.dart';
import 'package:favorite_places/widgets/dismiss_bkgrnd_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlaceListTile extends ConsumerWidget {
  const PlaceListTile({super.key, required this.place});
  final PlacesModel place;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(place.id),
      background: const DismissBackgroundTile(),
      onDismissed: (_) {
        ref.read(placesListProvider.notifier).delete(place.id);
      },
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (ctx) => PlaceDetails(place: place)));
        },
        child: SizedBox(
          width: double.infinity,
          child: Card(
            elevation: 5,
            color: Theme.of(context).colorScheme.secondaryContainer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
              child: ListTile(
                leading: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: CircleAvatar(
                    foregroundImage: FileImage(place.picture),
                  ),
                ),
                title: Text(
                  place.name,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Theme.of(context).colorScheme.secondary),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
