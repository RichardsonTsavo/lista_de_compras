abstract class ISharedPreferencesRepository {
  Future<String?> getString({required String key});
  Future<Map<String, dynamic>> getMap({required String key});
  Future<List<Map<String, dynamic>>> getAllMaps();
  Future removeData({required String key});
  Future deleteAll();
  Future saveString({required String key, required String data});
  Future saveMap({required String key, required Map<String, dynamic> data});
  Future saveListMap(
      {required String key, required List<Map<String, dynamic>> data});
  Future<List<Map<String, dynamic>>> getListMap({required String key});
}
