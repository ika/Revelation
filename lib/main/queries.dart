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
          t: "The Revelation of John\nI looked, and there was a door open into heaven");

      list.insert(0, heading);
      list.insertAll(list.length, addedLines); // add empty lines
    }

    return list;
  }
}
