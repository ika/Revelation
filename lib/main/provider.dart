import 'dart:io';
import 'package:revelation/utils/const.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class RevProvider {
  final int newDbVerson = 1;
  final String _dbName = Constants.revDatabase;

  RevProvider.internal();
  static final RevProvider _instance = RevProvider.internal();
  static Database? _database;

  factory RevProvider() => _instance;

  Future<Database> get database async {
    _database ??= await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, _dbName);

    if (!await databaseExists(path)) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", _dbName));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    Database db = await openDatabase(path);
    return db;
  }

  Future close() async {
    return _database!.close();
  }
}
