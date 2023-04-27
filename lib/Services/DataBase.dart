import 'dart:convert';

import 'package:my_library/Services/Intitlemodel/Intitlemodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBase {
  Future<Database> initializedDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'books.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE books(books_list TEXT)",
        );
      },
    );
  }
  Future<Database> initializedDB2() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'books2.db'),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE books2(books_list2 TEXT)",
        );
      },
    );
  }

// insert data
  Future<int> insertPlanets(String jsonString) async {
    int result = 0;
    final Database db = await initializedDB();
    print(jsonString);
    // for (var item in items) {
      result = await db.insert('books',{'books_list': jsonString} /*item.toMap()*/,
          conflictAlgorithm: ConflictAlgorithm.replace);
    // }
    return result;
  }
// insert data
  Future<int> insertPlanets2(String jsonString) async {
    int result = 0;
    final Database db = await initializedDB2();
    print(jsonString);
    // for (var item in items) {
      result = await db.insert('books2',{'books_list2': jsonString} /*item.toMap()*/,
          conflictAlgorithm: ConflictAlgorithm.replace);
    // }
    return result;
  }

// retrieve data
  Future<List<Item>> retrievePlanets() async {
    final Database db = await initializedDB();
    final List<Map<String, dynamic?>> queryResult = await db.query('books');
    List<dynamic> booksList = [];
    queryResult.forEach((row) {
      List<dynamic> books = jsonDecode(row['books_list']);
      booksList.addAll(books);
    });
    List<Item> itemList = booksList.map((book) => Item.fromMap(book)).toList();
    return itemList;
  }

// retrieve data
  Future<List<Item>> retrievePlanets2() async {
    final Database db = await initializedDB2();
    final List<Map<String, dynamic?>> queryResult = await db.query('books2');
    List<dynamic> booksList = [];
    queryResult.forEach((row) {
      List<dynamic> books = jsonDecode(row['books_list2']);
      booksList.addAll(books);
    });
    List<Item> itemList = booksList.map((book) => Item.fromMap(book)).toList();
    return itemList;
  }

// delete user
  Future<void> deletePlanet(int id) async {
    final db = await initializedDB();
    await db.delete(
      'books',
      where: "id = ?",
      whereArgs: [id],
    );
  }
}
