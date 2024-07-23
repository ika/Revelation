import 'package:revelation/main/model.dart';
import 'package:revelation/main/provider.dart';
import 'package:revelation/utils/const.dart';

RevProvider revProvider = RevProvider();
const String _dbTable = Constants.revTable;

class RevQueries {
  Future<List<Rev>> getRev() async {
    final db = await revProvider.database;

    // add empty lines at the end
    List<Rev> addedLines = [];

    final line = Rev(id: 0, t: '');

    for (int l = 0; l <= 15; l++) {
      addedLines.add(line);
    }

    final List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM $_dbTable");

    List<Rev> list = maps.isNotEmpty
        ? List.generate(
            maps.length,
            (i) {
              return Rev(
                id: maps[i]['id'],
                t: maps[i]['t'],
              );
            },
          )
        : [];

    if (list.isNotEmpty) {
      final heading = Rev(
          id: 0,
          t: "The Revelation of John\n(I looked, and there was a door open into heaven)");

      list.insert(0, heading);
      list.insertAll(list.length, addedLines); // add empty lines
    }

    return list;
  }

  Future<List<Rev>> getSearchedValues(String search) async {
    final db = await revProvider.database;

    List<Rev> returnList = [];
    final defList = Rev(id: 0, t: 'No search results.');
    returnList.add(defList);

    var res = await db.rawQuery(
        '''SELECT * FROM $_dbTable WHERE t LIKE '%$search%' ORDER BY id ASC''');

    List<Rev> list = res.isNotEmpty
        ? res.map((tableName) => Rev.fromJson(tableName)).toList()
        : returnList;

    return list;
  }
}
