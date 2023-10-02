import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlacesModel {
  final String id;
  final String name;
  final File picture;
  final Map<String, double> location;

  PlacesModel(
      {required this.name, required this.picture, required this.location})
      : id = uuid.v4();
}
