import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

String filePath = './rev.txt';
String dbPath = './rev.db';
String tableName = 'rev';

void main() async {
  if (!await File(dbPath).exists()) {
    final db = sqlite3.open(dbPath);
    db.execute('''
    CREATE TABLE $tableName (
      id INTEGER NOT NULL PRIMARY KEY,
      t TEXT NOT NULL
    );
  ''');

    // Prepare a statement to run it multiple times:
    final stmt = db.prepare('INSERT INTO $tableName (t) VALUES (?)');

    if (await File(filePath).exists()) {
      var text = File(filePath);
      //await text.readAsLines().then((lines) {
      await text.readAsString().then((fileAsString) {
        List<String> lines = fileAsString.split("\n");
        for (var i = 0; i < lines.length; i++) {
          // remove spaces
          var t = lines[i].replaceAll(RegExp(r"\s+"), " ");
          // remove new lines
          //var q = lines[i].replaceAll(RegExp(r"\n"), "*");
          //print(q);
          print(t.replaceAll('\n', '|'));
          //stmt..execute([t]);
        }
      });
    }
    stmt.dispose();
  } else {
    print("DATABASE EXISTS!");
  }
}
