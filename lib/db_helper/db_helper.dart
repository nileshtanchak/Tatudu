import 'package:sqflite/sqflite.dart';
import 'package:tatudu/models/tudu.dart';

class DBHelper {
  static late Database _database;
  static const String _tableName = "Tatudu";

  static Future initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/tatudu.db";

    // open the database
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $_tableName (id INTEGER PRIMARY KEY, title TEXT, desc TEXT)');
    });
  }

  static Future<int> insert(Tudu tudu) async {
    tudu.id = await _database.insert(_tableName, tudu.toJson(tudu));
    return tudu.id;
  }

  static Future<List<Tudu>> getAllTudu() async {
    List<Map<String, dynamic>> maps = await _database.query(
      _tableName,
      columns: ["id", "title", "desc"],
    );
    if (maps.length > 0) {
      return maps.map((e) => Tudu.fromJson(e)).toList();
    }
    return [];
  }

  static Future<int> update(Tudu tudu) async {
    return await _database.update(_tableName, tudu.toJson(tudu),
        where: 'id = ?', whereArgs: [tudu.id]);
  }

  static Future<int> delete(Tudu tudu) async {
    return await _database
        .delete(_tableName, where: 'id = ?', whereArgs: [tudu.id]);
  }
}
