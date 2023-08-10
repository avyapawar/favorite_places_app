import 'package:favorite_places_app/model/places.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key,required this.place});
  final Places place ;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Stack(
        children: [
          Image(image: FileImage(place.image),
          width:  double.infinity,
           height:  double.infinity,
           fit: BoxFit.cover,),
             

          
        ],
      ),
    );
  }
}
