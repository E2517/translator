import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:translator/models/languajes_models.dart';

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
    return await openDatabase(
      join(await getDatabasesPath(), 'languages_firebase.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE languages(id INTEGER PRIMARY KEY, english TEXT, spanish TEXT)",
        );
      },
      version: 1,
    );
  }

  insertLanguageRaw(Languages language) async {
    final db = await database;

    final res = await db.rawInsert(
        "INSERT Into Languages (id, english, spanish) "
        "VALUES ( ${language.id}, '${language.english}', '${language.spanish}' )");
    return res;
  }

  insertLanguage(Languages language) async {
    final db = await database;
    final res = await db.insert('Languages', language.toJson());
    return res;
  }

  Future<Languages> selectGetLanguages(int id) async {
    final db = await database;
    final res = await db.query('languages', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? Languages.fromJson(res.first) : null;
  }

  Future<List<Languages>> getAlllanguages() async {
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

  Future<int> updateLanguages(Languages nuevoScan) async {
    final db = await database;
    final res = await db.update('Languages', nuevoScan.toJson(),
        where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteLanguage(int id) async {
    final db = await database;
    final res = await db.delete('Languages', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Languages');
    return res;
  }
}
