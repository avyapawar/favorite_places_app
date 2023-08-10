import 'dart:convert';

import 'package:favorite_places_app/model/places.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:http/http.dart ' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PlaceLocation? pickedLocation;

  String get locationImage{
    if(pickedLocation == null){
return '' ;
    }
  final lat =pickedLocation!.lattitude ;
    final lng =pickedLocation!.longitude ;


    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%7C$lat,$lng&key=AIzaSyCql7ZDHvloJzcoi69-AFT2owJsnPJtwTw' ;
  }
  bool isGettingLocation = false;
  void getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

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

    locationData = await location.getLocation();
    var lat = locationData.latitude;
    var lgn = locationData.longitude;
    

    if (lat == null || lgn == null) {
      return;
    }
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lgn&key=AIzaSyCql7ZDHvloJzcoi69-AFT2owJsnPJtwTw');
    final response = await http.get(url);

    final data = json.decode(response.body);
    print(data);
    final address = data['results'][0]['formatted_address'];
    print(address);
    setState(() {
      pickedLocation =
          PlaceLocation(adress: address, lattitude: lat, longitude: lgn);
      isGettingLocation = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget previewContent = Text(
      'no location choosen',
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .bodyLarge!
          .copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
    if(pickedLocation != null){
previewContent = Image.network(locationImage , fit: BoxFit.cover,width:  double.infinity,);
    }
    if (isGettingLocation) {
      previewContent = const CircularProgressIndicator();
    }
    return Column(
      children: [
        Container(
            height: 170,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 1,
                    color: Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.2))),
            child: previewContent),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
                onPressed: getCurrentLocation,
                icon: const Icon(Icons.location_on),
                label: const Text('get current location')),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.map),
                label: const Text('select pn  map')),
          ],
        )
      ],
    );
  }
}
