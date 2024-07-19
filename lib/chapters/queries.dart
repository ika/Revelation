import 'dart:async';
import 'package:revelation/chapters/model.dart';
import 'package:revelation/chapters/provider.dart';
import 'package:revelation/utils/const.dart';
import 'package:revelation/utils/utils.dart';
import 'package:sqflite/sqflite.dart';


// Chapters

class CaQueries {
  final CaProvider provider = CaProvider();
  final String _dbTable = Constants.chapsTable;

  Future<void> saveBookMark(CaModel model) async {
    final db = await provider.database;

    model.subtitle = prepareText(model.subtitle, 150);

    await db.insert(
      _dbTable,
      model.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteChapter(int id) async {
    final db = await provider.database;
    await db.rawQuery('''DELETE FROM $_dbTable WHERE id=?''', [id]);
  }

  Future<List<CaModel>> getChapterList() async {
    final db = await provider.database;

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable ORDER BY id ASC");

    List<CaModel> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return CaModel(
                id: maps[i]['id'],
                title: maps[i]['title'],
                subtitle: maps[i]['subtitle'],
                doc: maps[i]['doc'],
                page: maps[i]['page'],
                para: maps[i]['para'],
              );
            },
          )
        : [];
    return list;
  }

  Future<int> getChapterExists(int doc, int page, int para) async {
    final db = await provider.database;

    var cnt = Sqflite.firstIntValue(
      await db.rawQuery(
          '''SELECT MAX(id) FROM $_dbTable WHERE doc=? AND page=? AND para=?''',
          [doc, page, para]),
    );
    return cnt ?? 0;
  }
}
