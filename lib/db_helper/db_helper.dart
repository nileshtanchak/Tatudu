import 'package:sqflite/sqflite.dart';
import 'package:tatudu/models/sub_tudu.dart';
import 'package:tatudu/models/tudu.dart';

class DBHelper {
  static late Database _database;
  static const String _taskTableName = "TaskTable";
  static const String _subTaskTableName = "SubTaskTable";

  static Future initDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = "$databasesPath/tatudu.db";

    // open the database
    _database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE $_taskTableName (id INTEGER PRIMARY KEY, title TEXT, desc TEXT)');

      await db.execute(
          'CREATE TABLE $_subTaskTableName (id INTEGER PRIMARY KEY, parentTuduId INTEGER, title TEXT, desc TEXT, isCompleted BOOLEAN)');
    });
  }

  static Future<int> insertTudu(Tudu tudu) async {
    tudu.id = await _database.insert(_taskTableName, tudu.toJson(tudu));
    return tudu.id;
  }

  static Future<int> insertSubTudu(SubTudu subTudu) async {
    subTudu.id =
        await _database.insert(_subTaskTableName, subTudu.toJson(subTudu));
    return subTudu.id;
  }

  static Future<List<Tudu>> getAllTudu() async {
    List<Map<String, dynamic>> maps = await _database.query(
      _taskTableName,
      columns: ["id", "title", "desc"],
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => Tudu.fromJson(e)).toList();
    }
    return [];
  }

  static Future<List<SubTudu>> getAllSubTudu(String parentTuduId) async {
    List<Map<String, dynamic>> maps = await _database.query(
      _subTaskTableName,
      columns: ["id", "parentTuduId", "title", "desc", "isCompleted"],
      where: 'parentTuduId = ?',
      whereArgs: [parentTuduId],
    );
    if (maps.isNotEmpty) {
      return maps.map((e) => SubTudu.fromJson(e)).toList();
    }
    return [];
  }

  static Future<int> updateTudu(Tudu tudu) async {
    return await _database.update(_taskTableName, tudu.toJson(tudu),
        where: 'id = ?', whereArgs: [tudu.id]);
  }

  static Future<int> setSubTuduIsCompleted(SubTudu subTudu) async {
    return await _database.update(_subTaskTableName, subTudu.toJson(subTudu),
        where: 'id = ?', whereArgs: [subTudu.id]);
  }

  static Future<int> delete(Tudu tudu) async {
    return await _database
        .delete(_taskTableName, where: 'id = ?', whereArgs: [tudu.id]);
  }
}
