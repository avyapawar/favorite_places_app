import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation(
      {required this.adress, required this.lattitude, required this.longitude});
  final double lattitude;
  final double longitude;
  final String adress;
}

class Places {
  Places(
      {required this.title, required this.image,
   id 
       })
      : id =  id ?? uuid.v4();
  final String title;
  final String id;
  final File image;

}
