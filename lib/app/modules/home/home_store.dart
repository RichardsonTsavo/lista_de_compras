import 'package:mobx/mobx.dart';

import '../../shared/models/shopping_list_model.dart';
import '../../shared/repositories/shared_preferences/index.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  final ISharedPreferencesRepository _sharedPreferencesRepository =
      SharedPreferencesRepository();

  List<ShoppingListModel> allShoppingList = [];
  ObservableList<ShoppingListModel> filteredShoppingList =
      ObservableList<ShoppingListModel>();

  Future<List<ShoppingListModel>> getShoppingList() async {
    List<Map<String, dynamic>> map =
        await _sharedPreferencesRepository.getAllMaps();
    List<ShoppingListModel> shoppingList = [];
    for (var element in map) {
      shoppingList.add(ShoppingListModel.fromMap(element));
    }
    return shoppingList;
  }

  @action
  Future saveShoppingList(ShoppingListModel shoppingList) async {
    await _sharedPreferencesRepository.saveMap(
      key: shoppingList.id!,
      data: shoppingList.toMap(),
    );
    allShoppingList.add(shoppingList);
    filteredShoppingList.add(shoppingList);
  }

  @action
  Future deleteShoppingList(String id) async {
    await _sharedPreferencesRepository.removeData(
      key: id,
    );
    allShoppingList.removeWhere((element) => element.id == id);
    filteredShoppingList.removeWhere((element) => element.id == id);
  }

  @action
  void initShoppingList(List<ShoppingListModel> shoppingList) {
    allShoppingList.clear();
    filteredShoppingList.clear();
    allShoppingList.addAll(shoppingList);
    filteredShoppingList.addAll(shoppingList);
  }

  @action
  void setFilter(String value) {
    filteredShoppingList.clear();
    filteredShoppingList.addAll(
      allShoppingList.where(
        (element) => element.name!.toLowerCase().contains(value.toLowerCase()),
      ),
    );
  }
}
