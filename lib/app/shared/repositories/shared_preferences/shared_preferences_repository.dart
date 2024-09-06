import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'shared_preferences_repository_interface.dart';

class SharedPreferencesRepository implements ISharedPreferencesRepository {
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  @override
  Future<String> getString({required String key}) async {
    return await prefs.then((value) => value.getString(key) ?? "");
  }

  @override
  Future removeData({required String key}) async {
    return await prefs.then((value) => value.remove(key));
  }

  @override
  Future deleteAll() async {
    return await prefs.then((value) => value.clear());
  }

  @override
  Future saveString({required String key, required String data}) async {
    return await prefs.then((value) => value.setString(key, data));
  }

  @override
  Future saveMap(
      {required String key, required Map<String, dynamic> data}) async {
    String info = json.encode(data);
    return await prefs.then((value) => value.setString(key, info));
  }

  @override
  Future<Map<String, dynamic>> getMap({required String key}) async {
    String? info = await prefs.then((value) => value.getString(key));
    return json.decode(info ?? "{}");
  }

  @override
  Future<List<Map<String, dynamic>>> getListMap({required String key}) async {
    List<String> info =
        await prefs.then((value) => value.getStringList(key) ?? []);
    List<Map<String, dynamic>> data = [];
    for (int i = 0; i < info.length; i++) {
      data.add(json.decode(info[i]));
    }
    return data;
  }

  @override
  Future saveListMap(
      {required String key, required List<Map<String, dynamic>> data}) async {
    List<String> info =
        List.generate(data.length, (index) => json.encode(data[index]));
    return await prefs.then((value) => value.setStringList(key, info));
  }

  @override
  Future<List<Map<String, dynamic>>> getAllMaps() async {
    Set<String> keys = await prefs.then((value) => value.getKeys());
    List<Map<String, dynamic>> allPrefs = [];
    for (String key in keys) {
      var value = await getMap(key: key);
      allPrefs.add(value);
    }
    return allPrefs;
  }
}
