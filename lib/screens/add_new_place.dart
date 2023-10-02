import 'dart:io';

import 'package:favorite_places/models/places_model.dart';
import 'package:favorite_places/providers/places_list_provider.dart';
import 'package:favorite_places/widgets/image_picker.dart';
import 'package:favorite_places/widgets/location_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlace extends ConsumerStatefulWidget {
  const AddNewPlace({super.key});

  @override
  ConsumerState<AddNewPlace> createState() => _AddNewPlaceState();
}

class _AddNewPlaceState extends ConsumerState<AddNewPlace> {
  final _formKey = GlobalKey<FormState>();
  File? _selectedPicture;
  Map<String, double>? _pickedLocation;

  void _setPicture(File picture) {
    setState(() {
      _selectedPicture = picture;
    });
  }

  void _setLocation(Map<String, double> location) {
    setState(() {
      _pickedLocation = location;
    });
  }

  void save(String? name) {
    if (_selectedPicture == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select an image to continue.')),
      );
      return;
    }

    if (_pickedLocation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a location to continue.')),
      );
      return;
    }

    ref.read(placesListProvider.notifier).append(PlacesModel(
        name: name!, picture: _selectedPicture!, location: _pickedLocation!));
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                  textAlign: TextAlign.center,
                  textCapitalization: TextCapitalization.words,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(6)),
                      borderSide: BorderSide(width: 1.5),
                    ),
                    label: Text('Name'),
                  ),
                  validator: (value) {
                    if (value != null &&
                        value.isNotEmpty &&
                        value.length >= 3) {
                      return null;
                    }
                    return 'Enter a valid name';
                  },
                  onSaved: (newValue) {
                    save(newValue);
                  },
                ),
                const SizedBox(height: 20),
                ImagePickerWidget(
                  setPicture: _setPicture,
                ),
                const SizedBox(height: 20),
                LocationPicker(
                  onLocationPicked: _setLocation,
                ),
                const SizedBox(height: 35),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 40),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                      }
                    },
                    child: const Text('Done'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
