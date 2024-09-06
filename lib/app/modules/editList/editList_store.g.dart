// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editList_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditListStore on _EditListStoreBase, Store {
  late final _$shoppingListAtom =
      Atom(name: '_EditListStoreBase.shoppingList', context: context);

  @override
  ShoppingListModel get shoppingList {
    _$shoppingListAtom.reportRead();
    return super.shoppingList;
  }

  bool _shoppingListIsInitialized = false;

  @override
  set shoppingList(ShoppingListModel value) {
    _$shoppingListAtom.reportWrite(
        value, _shoppingListIsInitialized ? super.shoppingList : null, () {
      super.shoppingList = value;
      _shoppingListIsInitialized = true;
    });
  }

  late final _$purchaseSumAtom =
      Atom(name: '_EditListStoreBase.purchaseSum', context: context);

  @override
  double get purchaseSum {
    _$purchaseSumAtom.reportRead();
    return super.purchaseSum;
  }

  @override
  set purchaseSum(double value) {
    _$purchaseSumAtom.reportWrite(value, super.purchaseSum, () {
      super.purchaseSum = value;
    });
  }

  late final _$updateProductAsyncAction =
      AsyncAction('_EditListStoreBase.updateProduct', context: context);

  @override
  Future<dynamic> updateProduct(
      {required ProductModel product, required BuildContext context}) {
    return _$updateProductAsyncAction
        .run(() => super.updateProduct(product: product, context: context));
  }

  late final _$createProductAsyncAction =
      AsyncAction('_EditListStoreBase.createProduct', context: context);

  @override
  Future<dynamic> createProduct(
      {required String nameProduct, required BuildContext context}) {
    return _$createProductAsyncAction.run(
        () => super.createProduct(nameProduct: nameProduct, context: context));
  }

  late final _$deleteProductAsyncAction =
      AsyncAction('_EditListStoreBase.deleteProduct', context: context);

  @override
  Future<dynamic> deleteProduct(
      {required BuildContext context, required String id}) {
    return _$deleteProductAsyncAction
        .run(() => super.deleteProduct(context: context, id: id));
  }

  late final _$_EditListStoreBaseActionController =
      ActionController(name: '_EditListStoreBase', context: context);

  @override
  void setPurchaseSum() {
    final _$actionInfo = _$_EditListStoreBaseActionController.startAction(
        name: '_EditListStoreBase.setPurchaseSum');
    try {
      return super.setPurchaseSum();
    } finally {
      _$_EditListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFilter(String value) {
    final _$actionInfo = _$_EditListStoreBaseActionController.startAction(
        name: '_EditListStoreBase.setFilter');
    try {
      return super.setFilter(value);
    } finally {
      _$_EditListStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
shoppingList: ${shoppingList},
purchaseSum: ${purchaseSum}
    ''';
  }
}
