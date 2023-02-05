import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStore {
  LocalStore._();

  static setDocId(String docId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("docId", docId);
  }

  static Future<String?> getDocId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString("docId");
  }

  static storeClear() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
  }


  static setLikes(String id) async {
    SharedPreferences local= await SharedPreferences.getInstance();
    List<String> lst= local.getStringList('likes') ?? [];
    lst.add(id);
    local.setStringList('likes', lst);

  }

  static Future<List<String>> getLikes() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('likes') ?? [];
    return list;
  }

  static removeLikes(int id) async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('likes') ?? [];
    list.removeWhere((element) => element==id.toString());
    store.setStringList('likes', list);
  }

  static setType(String newType) async {
    SharedPreferences local= await SharedPreferences.getInstance();
    List<String> lst= local.getStringList('types') ?? ["Kg", "Dona"];
    lst.add(newType);
    local.setStringList('types', lst);
  }

  static Future<List<String>> getType() async {
    SharedPreferences store = await SharedPreferences.getInstance();
    List<String> list = store.getStringList('types') ?? ["Kg", "Dona"];
    return list;
  }





}
