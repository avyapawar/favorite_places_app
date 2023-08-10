import 'package:favorite_places_app/model/places.dart';
import 'package:favorite_places_app/providers/user_places.dart';
import 'package:favorite_places_app/screens/add_new_place_Screen.dart';
import 'package:favorite_places_app/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlacesScreen extends ConsumerWidget {
  const PlacesScreen({super.key});

  @override
 Widget build(BuildContext context,WidgetRef ref) {
     void onAddPlace() async {
    await Navigator.of(context)
        .push<Places>(MaterialPageRoute(builder: (context) {
      return const AddNewPlaceScreen();
    }));
  }
  final userPlaces =   ref.watch(userplaceProvider) ;
  print(userPlaces) ;
    return Scaffold(
      appBar: AppBar(
        title: Text('Your places',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground)),
        actions: [
          IconButton(
              onPressed: onAddPlace,
              icon: const Icon(
                Icons.add,
                size: 30,
              ))
        ],
      ),
      body:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: PlacesList(placesList: userPlaces),
      ),
    );

   
  }
}
 

  
