import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:translator/models/languajes_models.dart';

export 'package:translator/models/languajes_models.dart';

class SQLiteDatabase {
  static Database _database;
  static final SQLiteDatabase db = SQLiteDatabase._();

  SQLiteDatabase._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'language_firebase.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE languages ('
          ' id INTEGER PRIMARY KEY,'
          ' english TEXT,'
          ' spanish TEXT'
          ')');
    });
  }

  insertLanguagesByRaw(Languages lang) async {
    final db = await database;

    final res =
        await db.rawInsert("INSERT Into languages (id, english, spanish) "
            "VALUES ( ${lang.id}, '${lang.english}', '${lang.spanish}' )");
    return res;
  }

  insertLanguages(Languages lang) async {
    final db = await database;
    final res = await db.insert('languages', lang.toMap());
    return res;
  }

  Future<Languages> getLanguagesById(int id) async {
    final db = await database;
    final res = await db.query('languages', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Languages.fromJson(res.first) : null;
  }

  Future<List<Languages>> getAllLanguages() async {
    final db = await database;
    final res = await db.query('languages');

    List<Languages> list =
        res.isNotEmpty ? res.map((c) => Languages.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Languages>> getLanguage(String language) async {
    final db = await database;
    final res = await db.rawQuery('SELECT $language FROM languages');

    List<Languages> list =
        res.isNotEmpty ? res.map((c) => Languages.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Languages>> getLanguageByIndex(String language, int index) async {
    final db = await database;
    final res =
        await db.rawQuery('SELECT $language FROM languages WHERE id=$index');

    List<Languages> list =
        res.isNotEmpty ? res.map((c) => Languages.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> updateLanguages(Languages language) async {
    final db = await database;
    final res = await db.update('languages', language.toMap(),
        where: 'id = ?', whereArgs: [language.id]);
    return res;
  }

  Future<int> deleteLanguage(int id) async {
    final db = await database;
    final res = await db.delete('languages', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM languages');
    return res;
  }
  
  Future<void> checkDatabase() async {
    print('Data ${await SQLiteDatabase.db.getAllLanguages()}');
    SQLiteDatabase.db.deleteAll();
    print(await SQLiteDatabase.db.getLanguageByIndex('english', 0));
  }
  
}
