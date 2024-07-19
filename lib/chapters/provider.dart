import 'dart:io';
import 'package:revelation/utils/const.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Chapters

class CaProvider {
  final int newDbVerson = 1;

  final String _dbName = Constants.chapsDatabase;

  CaProvider.internal();

  static dynamic _database;

  static final CaProvider _instance = CaProvider.internal();

  factory CaProvider() => _instance;

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

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);

      db = await openDatabase(path);

      db.setVersion(newDbVerson);
    }
    return db;
  }

  Future close() async {
    return _database!.close();
  }
}
