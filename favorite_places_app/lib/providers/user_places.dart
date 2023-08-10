import 'dart:io';
import 'package:favorite_places_app/model/places.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart ' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDataBase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE user_places(id TEXT PRIMARY KEY ,title TEXT , image TEXT)',
      );
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<Places>> {
  UserPlacesNotifier() : super([]);

  void loadData() async {
    final db = await _getDataBase();
    final data = await db.query('user_places');
    final places =data.map(
      (row) => Places(
        id: row['id'],
        title: row['title'] as String,
        image: File(
          row['image'] as String,
        ),
      ),
    ).toList();
    state = places ;
  }

  void addPlace(String title, File image) async {
    final appDirectory = syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final copiedImage = await image.copy('$appDirectory/$fileName');

    final newPlace = Places(title: title, image: image);

    final db = await _getDataBase();
    db.insert('user_places', {
      'title': newPlace.title,
      'id': newPlace.id,
      'image': newPlace.image.path
    });
    state = [newPlace, ...state];
  }
}

final userplaceProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Places>>(
        (ref) => UserPlacesNotifier());
