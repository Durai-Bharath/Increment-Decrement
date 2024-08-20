import 'package:flutter_assignment/db_helper/api_handler.dart';
import 'package:flutter_assignment/model/model.dart';

class Query {
  late ApiHandler handler;
  Query() {
    handler = ApiHandler();
  }

  //Insert Data
  Future<bool> insertUser(Model model) async {
    var res = await handler.insertData("user", model.toMap());
    if (res > 0) {
      return true;
    }
    return false;
  }
 
  //User Name Exist Functions
  Future<bool> isUserNameExist(String name) async {
    var res = await getUserData(name);
    if (res == null) {
      return false;
    }
    return true;
  }

  Future<Model?>? getUserData(String name) async {
    var res = await handler.readDataByName("user", name);
    if (res.length >= 1) {
      return Model.fromMap(res[0]);
    }
    return null;
  }

  Future<Model?>? sigin(String name, String password) async {
    var res = await handler.signInUser('user', name, password);
    if (res.length > 0) {
      return Model.fromMap(res[0]);
    } else {
      return null;
    }
  }

  updateData(Model model) async {
    return await handler.updateData("user", model.toMap());
  }
}
