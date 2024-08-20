import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseConnection {
  Future<Database> setDatabase() async {
    var directory = await getApplicationDocumentsDirectory();
    var path = p.join(directory.path, 'users.db');

    var database = await openDatabase(
      path,
      version: 1,
      onCreate: (database, version) async {
        String sql =
            "CREATE TABLE user(name TEXT PRIMARY KEY,password TEXT,value INTEGER);";
        await database.execute(sql);
      },
    );
    return database;
  }
}
