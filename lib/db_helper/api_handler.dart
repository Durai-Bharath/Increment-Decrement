import 'package:flutter_assignment/db_helper/database_connection.dart';
import 'package:sqflite/sqflite.dart';

class ApiHandler {
  late DataBaseConnection dataBaseConnection;
  ApiHandler() {
    dataBaseConnection = DataBaseConnection();
  }

  static Database? _db;

  Future<Database?> get database async {
    if (_db != null) {
      return _db;
    } else {
      _db = await dataBaseConnection.setDatabase();
      return _db;
    }
  }

  //Insert
  insertData(table, data) async {
    var connection = await database;
    return await connection?.insert(table, data);
  }

  // read data by name
  readDataByName(table, name) async {
    var connection = await database;
    return await connection?.query(table, where: 'name=?', whereArgs: [name]);
  }

  //Sigin
  signInUser(table, name, password) async {
    var connection = await database;
    return await connection?.query(table,
        where: 'name=? AND password=?', whereArgs: [name, password]);
  }

  //update
  updateData(table, data) async {
    var connection = await database;
    return await connection
        ?.update(table, data, where: 'name=?', whereArgs: [data["name"]]);
  }
}
