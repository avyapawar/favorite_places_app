import 'dart:io';

import 'package:favorite_places_app/providers/user_places.dart';
import 'package:favorite_places_app/widgets/image_input.dart';
import 'package:favorite_places_app/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddNewPlaceScreen extends ConsumerStatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  ConsumerState<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends ConsumerState<AddNewPlaceScreen> {
  File? selectedImage;
  final _titleController = TextEditingController();

  void savePlace(String text) {
    final enteredText = text;
    if (enteredText.isEmpty || selectedImage == null) {
      return;
    }
    ref
        .read(userplaceProvider.notifier)
        .addPlace(enteredText , selectedImage!);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new place'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                controller: _titleController,
                decoration: InputDecoration(
                    label: Text(
                  'Title',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              ImageInput(
                onPickImage: (image) {
                  selectedImage = image;
                },
              ),
              const SizedBox(
                height: 20,
              ),
               const LocationInput(),
               const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.background)),
                      onPressed: () {
                        savePlace(_titleController.text);
                      },
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 10,
                          ),
                          Text('add place')
                        ],
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
