import 'package:revelation/utils/const.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


// Bookmarks database helper

class BMProvider {
  final int newDbVerson = 1;

  final String _dbName = Constants.bmarksDatabase;
  final String _dbTable = Constants.bmarksTable;

  BMProvider.internal();

  static dynamic _database;

  static final BMProvider _instance = BMProvider.internal();

  factory BMProvider() => _instance;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    Database db = await openDatabase(path);

    // not exists returns zero
    if (await db.getVersion() < newDbVerson) {
      db.close();
      await deleteDatabase(path);

      db = await openDatabase(
        path,
        version: newDbVerson,
        onOpen: (db) async {},
        onCreate: (Database db, int version) async {
          await db.execute('''
                CREATE TABLE IF NOT EXISTS $_dbTable (
                    id INTEGER PRIMARY KEY,
                    title TEXT DEFAULT '',
                    subtitle TEXT DEFAULT '',
                    doc INTEGER DEFAULT 0,
                    page INTEGER DEFAULT 0,
                    para INTEGER DEFAULT 0
                )
            ''');
        },
      );
    }
    return db;
  }

  Future close() async {
    return _database!.close();
  }
}
