//import 'dart:html';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite2/database/database_model.dart';
import 'package:sqflite2/dog/cat.dart';
import 'package:sqflite2/dog/dog.dart';


class MyDatabase {
  Future<Database> dogDatabase() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        'dogs_db.db',
      ),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<Database> catDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'cats_db.db'),
      onCreate: (db, version) {
        // Run the CREATE TABLE statement on the database.
        return db.execute(
          "CREATE TABLE cats(id INTEGER PRIMARY KEY, name TEXT, age INTEGER)",
        );
      },
      version: 1,
    );
  }

  Future<Database> getDatabase(DatabaseModel model) async {
    return await getDatabaseByName(model.database());
  }

  Future<Database> getDatabaseByName(String db_name) async {
    switch (db_name) {
      case 'dogs_db':
        return await dogDatabase();
        break;
      case 'cats_db':
        return await catDatabase();
        break;
      default:
        return null;
        break;
    }
  }

  Future<void> insert(DatabaseModel model) async {
    final Database db = await getDatabase(model);
    await db.insert(
      model.table(),
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    db.close();
  }

  Future<void> update(DatabaseModel model) async {
    final Database db = await getDatabase(model);
    await db.update(
      model.table(),
      model.toMap(),
      where: 'id=?',
      whereArgs: [model.getID()],
    );
    db.close();
  }

  Future<void> delete(DatabaseModel model) async {
    final Database db = await getDatabase(model);
    await db.delete(
      model.table(),
      where: 'id=?',
      whereArgs: [model.getID()],
    );
  }

  Future<List<DatabaseModel>> getAll(String table, String db_name) async {
    final Database db = await getDatabaseByName(db_name);
    final List<Map<String, dynamic>> maps = await db.query(table);
    List<DatabaseModel> models = [];
    for (var item in maps) {
      switch (table) {
        case 'dogs':
          models.add(
            Dog.fromMap(item),
          );
          break;
        case 'cats':
          models.add(
            Cat.fromMap(item),
          );
          break;
      }
    }
    return models ;
  }
}
