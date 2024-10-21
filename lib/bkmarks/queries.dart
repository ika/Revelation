import 'dart:async';
import 'package:revelation/bkmarks/model.dart';
import 'package:revelation/bkmarks/provider.dart';
import 'package:revelation/utils/const.dart';
import 'package:sqflite/sqflite.dart';

// Bookmarks database helper

List<BmModel> noneFound() {
  List<BmModel> returnList = [];

  final defList = BmModel(
      id: 0,
      title: 'Revelation',
      subtitle: 'No Bookmarks found!',
      doc: 0,
      page: 0,
      para: 0);

  returnList.add(defList);

  return returnList;
}

class BMQueries {
  final BMProvider provider = BMProvider();
  final String _dbTable = Constants.bmarksTable;

  Future<void> saveBookMark(BmModel model) async {
    final db = await provider.database;

    await db.insert(
      _dbTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteBookMark(int id) async {
    final db = await provider.database;
    await db.rawQuery('''DELETE FROM $_dbTable WHERE id=?''', [id]);
  }

  Future<List<BmModel>> getBookMarkList() async {
    final db = await provider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable ORDER BY id DESC");

    List<BmModel> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return BmModel(
                id: maps[i]['id'],
                title: maps[i]['title'],
                subtitle: maps[i]['subtitle'],
                doc: maps[i]['doc'],
                page: maps[i]['page'],
                para: maps[i]['para'],
              );
            },
          )
        : noneFound();
    return list;
  }

  Future<int> getBookMarkExists(int doc, int page, int para) async {
    final db = await provider.database;

    var cnt = Sqflite.firstIntValue(
      await db.rawQuery(
          '''SELECT MAX(id) FROM $_dbTable WHERE doc=? AND page=? AND para=?''',
          [doc, page, para]),
    );
    return cnt ?? 0;
  }
}
