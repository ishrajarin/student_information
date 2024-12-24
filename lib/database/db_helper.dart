import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // database name
  static const databaseName = "student.db";
  // database version
  static const databaseVersion = 1;
  // table name
  static const tableNotes = 'student';
  // column names
  static const columnId = 'id';
  static const columnname = 'name';
  static const columnstudentid = 'studentid';
  static const columnphone = 'phone';
  static const columnemail = 'email';
  static const columnlocation = 'location';

  // create a single instance of DatabaseHelper
  DatabaseHelper.privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper.privateConstructor();

  static Database? myDb;

  // for initializing the database
  Future<Database?> get database async {
    if (myDb != null) return myDb;

    myDb = await _initDatabase();
    return myDb;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(
      path,
      version: databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $tableNotes (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnname TEXT NOT NULL,
            $columnstudentid TEXT NOT NULL,
            $columnphone TEXT NOT NULL,
            $columnemail TEXT NOT NULL,
            $columnlocation TEXT NOT NULL
          )
          ''');
  }

  // CRUD operations
  Future<int> insertData(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(tableNotes, row);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    Database? db = await instance.database;
    return await db!.query(tableNotes);
  }

  Future<int> deleteData(int id) async {
    Database? db = await instance.database;
    return await db!.delete(tableNotes, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateData(Map<String, dynamic> row, int id) async {
    Database? db = await instance.database;
    return await db!.update(tableNotes, row, where: '$columnId = ?', whereArgs: [id]);
  }
}