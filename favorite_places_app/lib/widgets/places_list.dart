import 'package:favorite_places_app/model/places.dart';
import 'package:favorite_places_app/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({super.key, required this.placesList});
  final List<Places> placesList;

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
        child: Text(
      'no places added yet',
       style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
    ));
    if (placesList.isNotEmpty) {
      content = ListView.builder(
          itemCount: placesList.length,
          itemBuilder: (context, index) {
            return ListTile(
        leading: CircleAvatar(
          radius: 26,
          backgroundImage: FileImage(placesList[index].image),
        ),
        title: Text(
          placesList[index].title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => PlaceDetailsScreen(place: placesList[index]),
            ),
          );
        },
      );
          });
    }
    return content;
  }
}
