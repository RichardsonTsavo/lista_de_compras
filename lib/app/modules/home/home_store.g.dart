// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$HomeStore on HomeStoreBase, Store {
  late final _$saveShoppingListAsyncAction =
      AsyncAction('HomeStoreBase.saveShoppingList', context: context);

  @override
  Future<dynamic> saveShoppingList(ShoppingListModel shoppingList) {
    return _$saveShoppingListAsyncAction
        .run(() => super.saveShoppingList(shoppingList));
  }

  late final _$deleteShoppingListAsyncAction =
      AsyncAction('HomeStoreBase.deleteShoppingList', context: context);

  @override
  Future<dynamic> deleteShoppingList(String id) {
    return _$deleteShoppingListAsyncAction
        .run(() => super.deleteShoppingList(id));
  }

  late final _$HomeStoreBaseActionController =
      ActionController(name: 'HomeStoreBase', context: context);

  @override
  void initShoppingList(List<ShoppingListModel> shoppingList) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.initShoppingList');
    try {
      return super.initShoppingList(shoppingList);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(String value) {
    final _$actionInfo = _$HomeStoreBaseActionController.startAction(
        name: 'HomeStoreBase.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$HomeStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
