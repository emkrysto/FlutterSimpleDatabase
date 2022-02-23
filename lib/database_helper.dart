import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'hours.dart';

class DatabaseHelper {
  static const _databaseName = "timeHheetDB.db";
  static const _databaseVersion = 1;

  static const table = 'hours';

  static const columnId = 'id';
  static const columnDate = 'd1';
  static const columnHours = 't1';
  static const columnOvertime = 't2';
  static const columnDesc = 'desc';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnDate DATETIME NOT NULL,
            $columnHours INTEGER NOT NULL,
            $columnOvertime INTEGER NOT NULL,
            $columnDesc TEXT NOT NULL
          )
          ''');
  }

  Future<int?> insert(Hours row) async {
    Database? db = await instance.database;
    print('row: ' + row.toMap().toString());
    return await db?.insert(
      table,
      row.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, Object?>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }

  Future<int?> queryRowCount() async {
    Database? db = await instance.database;
    return Sqflite.firstIntValue(
        await db!.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<List<Hours>> retrieveUsers() async {
    Database? db = await instance.database;
    final List<Map<String, Object?>> queryResult = await db!.query('hours');
    print('queryResult: $queryResult');
    return queryResult.map((e) => Hours.fromMap(e)).toList();
  }

  Future<int?> update(Hours row, int id) async {
    Database? db = await instance.database;
    print('row: ' + row.updateToMap().toString());
    return await db?.update(table, row.updateToMap(),
        where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int?> delete(int id) async {
    Database? db = await instance.database;
    return await db?.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
