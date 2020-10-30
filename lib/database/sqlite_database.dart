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
    final res = await db.insert('languages', lang.toJson());
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

  Future<List<Languages>> getLanguagesEnglish(String english) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM languages WHERE english='$english'");

    List<Languages> list =
        res.isNotEmpty ? res.map((c) => Languages.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Languages>> getLanguagesSpanish(String spanish) async {
    final db = await database;
    final res =
        await db.rawQuery("SELECT * FROM languages WHERE spanish='$spanish'");

    List<Languages> list =
        res.isNotEmpty ? res.map((c) => Languages.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<Languages>> getLanguageEnglish() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('languages');

    return List.generate(maps.length, (i) {
      return Languages(
        english: maps[i]['english'],
      );
    });
  }

  Future<List<Languages>> getLanguageSpanish() async {
    final Database db = await database;

    final List<Map<String, dynamic>> maps = await db.query('languages');

    return List.generate(maps.length, (i) {
      return Languages(
        spanish: maps[i]['spanish'],
      );
    });
  }

  Future<int> updateLanguages(Languages language) async {
    final db = await database;
    final res = await db.update('languages', language.toJson(),
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
}

// import 'dart:async';
// import 'package:flutter/widgets.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:translator/models/languajes_models.dart';

// class MyDatabase {
//   void initDB() async {
//     WidgetsFlutterBinding.ensureInitialized();
//     final Future<Database> database = openDatabase(
//       join(await getDatabasesPath(), 'language_database.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           "CREATE TABLE languages(id INTEGER PRIMARY KEY, english TEXT, spanish TEXT)",
//         );
//       },
//       version: 1,
//     );

//     Future<void> insertLanguage(Languages lang) async {
//       final Database db = await database;

//       // Insert the Languages into the correct table. Also specify the
//       // `conflictAlgorithm`. In this case, if the same languages is inserted
//       // multiple times, it replaces the previous data.
//       await db.insert(
//         'languages',
//         lang.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace,
//       );
//     }

//     Future<List<Languages>> getAllLanguages() async {
//       final Database db = await database;

//       final List<Map<String, dynamic>> maps = await db.query('languages');

//       return List.generate(maps.length, (i) {
//         return Languages(
//           id: maps[i]['id'],
//           english: maps[i]['english'],
//           spanish: maps[i]['spanish'],
//         );
//       });
//     }

//     Future<List<Languages>> getLanguageEnglish() async {
//       final Database db = await database;

//       final List<Map<String, dynamic>> maps = await db.query('languages');

//       return List.generate(maps.length, (i) {
//         return Languages(
//           english: maps[i]['english'],
//         );
//       });
//     }

//     Future<List<Languages>> getLanguageSpanish() async {
//       final Database db = await database;

//       final List<Map<String, dynamic>> maps = await db.query('languages');

//       return List.generate(maps.length, (i) {
//         return Languages(
//           spanish: maps[i]['spanish'],
//         );
//       });
//     }

//     Future<void> updateLanguage(Languages lang) async {
//       final db = await database;

//       await db.update(
//         'languages',
//         lang.toMap(),
//         where: "id = ?",
//         whereArgs: [lang.id],
//       );
//     }

//     Future<void> deleteLanguage(int id) async {
//       final db = await database;

//       await db.delete(
//         'languages',
//         where: "id = ?",
//         whereArgs: [id],
//       );
//     }

//     var data = Languages(
//       id: 0,
//       english: 'Hello',
//       spanish: 'Hola',
//     );

//     await insertLanguage(data);

//     print(await getAllLanguages());

//     var updatedata = Languages(
//       id: 0,
//       english: 'Bye',
//       spanish: 'Adios',
//     );

//     await updateLanguage(updatedata);

//     print(await getAllLanguages());

//     print(await getLanguageEnglish());

//     print(await getLanguageSpanish());

//     await deleteLanguage(updatedata.id);

//     print(await getAllLanguages());
//   }
// }

// class SQLiteDatabase {
//   static Database _database;
//   static final SQLiteDatabase db = SQLiteDatabase._();

//   SQLiteDatabase._();

//   Future<Database> get database async {
//     if (_database != null) return _database;

//     _database = await initDB();
//     return _database;
//   }

//   initDB() async {
//     return await openDatabase(
//       join(await getDatabasesPath(), 'languages_firebase.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           "CREATE TABLE languages(id INTEGER PRIMARY KEY, english TEXT, spanish TEXT)",
//         );
//       },
//       version: 1,
//     );
//   }

//   insertLanguageRaw(Languages language) async {
//     final db = await database;

//     final res = await db.rawInsert(
//         "INSERT Into languages (id, english, spanish) "
//         "VALUES ( ${language.id}, '${language.english}', '${language.spanish}' )");
//     return res;
//   }

//   insertLanguage(Languages language) async {
//     final db = await database;
//     final res = await db.insert('languages', language.toJson());
//     return res;
//   }

//   Future<Languages> selectGetLanguages(int id) async {
//     final db = await database;
//     final res = await db.query('languages', where: 'id = ?', whereArgs: [id]);
//     return res.isNotEmpty ? Languages.fromJson(res.first) : null;
//   }

//   Future<List<Languages>> getAlllanguages() async {
//     final db = await database;
//     final res = await db.query('languages');

//     List<Languages> list =
//         res.isNotEmpty ? res.map((c) => Languages.fromJson(c)).toList() : [];
//     return list;
//   }

//   Future<List<Languages>> getLanguagesEnglish(String english) async {
//     final db = await database;
//     final res =
//         await db.rawQuery("SELECT * FROM languages WHERE english='$english'");

//     List<Languages> list =
//         res.isNotEmpty ? res.map((c) => Languages.fromJson(c)).toList() : [];
//     return list;
//   }

//   Future<List<Languages>> getLanguagesSpanish(String spanish) async {
//     final db = await database;
//     final res =
//         await db.rawQuery("SELECT * FROM languages WHERE spanish='$spanish'");

//     List<Languages> list =
//         res.isNotEmpty ? res.map((c) => Languages.fromJson(c)).toList() : [];
//     return list;
//   }

//   Future<int> updateLanguages(Languages language) async {
//     final db = await database;
//     final res = await db.update('languages', language.toJson(),
//         where: 'id = ?', whereArgs: [language.id]);
//     return res;
//   }

//   Future<int> deleteLanguage(int id) async {
//     final db = await database;
//     final res = await db.delete('languages', where: 'id = ?', whereArgs: [id]);
//     return res;
//   }

//   Future<int> deleteAll() async {
//     final db = await database;
//     final res = await db.rawDelete('DELETE FROM languages');
//     return res;
//   }
// }
