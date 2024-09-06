import 'package:flutter/material.dart';
import 'package:lista_de_compras/app/shared/models/product_model.dart';
import 'package:lista_de_compras/app/shared/utils/utils.dart';
import 'package:mobx/mobx.dart';

import '../../shared/models/shopping_list_model.dart';
import '../../shared/repositories/shared_preferences/index.dart';

part 'editList_store.g.dart';

class EditListStore = _EditListStoreBase with _$EditListStore;

abstract class _EditListStoreBase with Store {
  final ISharedPreferencesRepository _sharedPreferencesRepository =
      SharedPreferencesRepository();
  @observable
  late ShoppingListModel shoppingList;

  ObservableList<ProductModel> filteredProducts =
      ObservableList<ProductModel>();

  @observable
  double purchaseSum = 0;

  void sortProducts() {
    filteredProducts.sort(
      (a, b) {
        if (a.isPurchased! && !b.isPurchased!) {
          return 1;
        } else if (!a.isPurchased! && b.isPurchased!) {
          return -1;
        } else {
          return 0;
        }
      },
    );
  }

  @action
  void setPurchaseSum() {
    double value = 0;
    for (var element in shoppingList.products!) {
      if (element.isPurchased == true) {
        value += (element.price! * element.amount!);
      }
    }
    purchaseSum = value;
  }

  void init(ShoppingListModel value) {
    shoppingList = value;
    filteredProducts.addAll(value.products!);
    filteredProducts.shuffle();
    setPurchaseSum();
    sortProducts();
  }

  @action
  void setFilter(String value) {
    filteredProducts.clear();
    filteredProducts.addAll(
      shoppingList.products!.where(
        (element) => element.name!.toLowerCase().contains(value.toLowerCase()),
      ),
    );
  }

  Future save() async {
    return await _sharedPreferencesRepository.saveMap(
      key: shoppingList.id!,
      data: shoppingList.toMap(),
    );
  }

  @action
  Future updateProduct(
      {required ProductModel product, required BuildContext context}) async {
    try {
      List<ProductModel> currentProducts = shoppingList.products!;
      for (var i = 0; i < currentProducts.length; i++) {
        if (currentProducts[i].id == product.id) {
          currentProducts[i] = product;
        }
      }

      shoppingList = shoppingList.copyWith(products: currentProducts);
      filteredProducts.clear();
      filteredProducts.addAll(shoppingList.products!);
      await save();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.showSnackBar(
            context: context, mensage: "Produto atualizado com sucesso!");
      });
      setPurchaseSum();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.showSnackBar(
            context: context, mensage: "Erro ao atualizar produto");
      });
    }
  }

  @action
  Future createProduct(
      {required String nameProduct, required BuildContext context}) async {
    try {
      ProductModel product = ProductModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        amount: 1,
        image: "",
        isPurchased: false,
        name: nameProduct,
        price: 0,
      );
      shoppingList =
          shoppingList.copyWith(products: [...shoppingList.products!, product]);
      filteredProducts.add(product);
      await save();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.showSnackBar(
            context: context, mensage: "Produto criado com sucesso!");
      });
      setPurchaseSum();
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.showSnackBar(context: context, mensage: "Erro ao criar produto");
      });
    }
  }

  @action
  Future deleteProduct(
      {required BuildContext context, required String id}) async {
    try {
      shoppingList.products!.removeWhere((element) => element.id == id);
      filteredProducts.removeWhere((element) => element.id == id);
      await save();
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.showSnackBar(
            context: context, mensage: "Produto deletado da memoria");
      });
    } catch (e) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Utils.showSnackBar(
            context: context, mensage: "Erro ao deletar produto da memoria");
      });
    }
    setPurchaseSum();
  }
}
