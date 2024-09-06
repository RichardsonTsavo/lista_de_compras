import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_de_compras/app/modules/editList/editList_store.dart';

import '../../shared/models/shopping_list_model.dart';
import '../../shared/utils/utils.dart';
import '../../shared/widgets/animated_list/animated_list_widget.dart';

class EditListPage extends StatefulWidget {
  final ShoppingListModel shoppingListModel;
  final String title;
  const EditListPage({
    super.key,
    this.title = 'EditListPage',
    required this.shoppingListModel,
  });
  @override
  EditListPageState createState() => EditListPageState();
}

class EditListPageState extends State<EditListPage> {
  final EditListStore store = Modular.get();

  @override
  void initState() {
    store.init(widget.shoppingListModel);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (store.shoppingList.products != widget.shoppingListModel.products) {
          Modular.to.pop(true);
        } else {
          Modular.to.pop();
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              widget.shoppingListModel.name!,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
              ),
              onPressed: () {
                if (store.shoppingList.products !=
                    widget.shoppingListModel.products) {
                  Modular.to.pop(true);
                } else {
                  Modular.to.pop();
                }
              },
            ),
            actions: [
              Observer(builder: (_) {
                return Text(
                  UtilBrasilFields.obterReal(store.purchaseSum),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                );
              }),
              const SizedBox(
                width: 15,
              )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              String nameProduct = "";
              Utils.showPopupDialog(
                context: context,
                child: AlertDialog(
                  actionsAlignment: MainAxisAlignment.spaceEvenly,
                  backgroundColor: Colors.white,
                  title: const Text(
                    "Adicionar produto a lista",
                    textAlign: TextAlign.center,
                  ),
                  content: TextField(
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      labelText: "Nome do produto",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    onChanged: (value) {
                      nameProduct = value;
                    },
                  ),
                  actions: [
                    ElevatedButton(
                      onPressed: () async {
                        if (nameProduct.isNotEmpty) {
                          Navigator.of(context).pop();
                          await store.createProduct(
                            nameProduct: nameProduct,
                            context: context,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Adicione um nome do produto'),
                            ),
                          );
                        }
                      },
                      child: const Text("Criar produto"),
                    )
                  ],
                ),
              );
            },
            child: const Icon(
              Icons.add_box_rounded,
              color: Colors.black,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  cursorColor: Colors.white,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                    labelText: "Pesquise pelo nome",
                    hintStyle: const TextStyle(color: Colors.white),
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onChanged: (value) {
                    store.setFilter(value);
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Observer(builder: (_) {
                    return AnimatedListWidget(
                      listType: ListType.LIST,
                      childs: List.generate(
                        store.filteredProducts.length,
                        (index) => Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              onTap: () {
                                int amount =
                                    store.filteredProducts[index].amount!;
                                bool isPurchased =
                                    store.filteredProducts[index].isPurchased!;
                                double price =
                                    store.filteredProducts[index].price!;
                                String name =
                                    store.filteredProducts[index].name!;
                                Utils.showPopupDialog(
                                  context: context,
                                  child: AlertDialog(
                                    scrollable: true,
                                    backgroundColor: Colors.white,
                                    insetPadding: EdgeInsets.zero,
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    actionsAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    title: Text(
                                      "Editar: ${store.filteredProducts[index].name}",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          initialValue: name,
                                          cursorColor: Colors.black,
                                          decoration: InputDecoration(
                                            labelText: "Nome do produto",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            name = value;
                                          },
                                        ),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        TextFormField(
                                          initialValue:
                                              UtilBrasilFields.obterReal(price),
                                          cursorColor: Colors.black,
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                            CentavosInputFormatter()
                                          ],
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            labelText: "Preço do produto",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              borderSide: const BorderSide(
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          onChanged: (value) {
                                            if (value.isNotEmpty) {
                                              price = UtilBrasilFields
                                                  .converterMoedaParaDouble(
                                                value,
                                              );
                                            } else {
                                              price = 0;
                                            }
                                          },
                                        ),
                                        StatefulBuilder(
                                          builder: (context, state) {
                                            return SwitchListTile(
                                              value: isPurchased,
                                              title: const Text(
                                                  "O produto ja está no carrinho?"),
                                              onChanged: (value) {
                                                state(() {
                                                  isPurchased = value;
                                                });
                                              },
                                            );
                                          },
                                        ),
                                        StatefulBuilder(
                                          builder: (context, state) {
                                            return ListTile(
                                              title: const Text("Quantidade"),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton.filled(
                                                    onPressed: () {
                                                      state(() {
                                                        if (amount > 1) {
                                                          amount--;
                                                        }
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 15.0,
                                                    ),
                                                    child: Text(
                                                      amount.toString(),
                                                      style: const TextStyle(
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                  ),
                                                  IconButton.filled(
                                                    onPressed: () {
                                                      state(() {
                                                        amount++;
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                        ),
                                        onPressed: () async {
                                          Modular.to.pop();
                                          Utils.showPopupDialog(
                                            context: context,
                                            child: AlertDialog(
                                              actionsAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              backgroundColor: Colors.white,
                                              title: Text(
                                                  "Deseja deletar o produto ${store.filteredProducts[index].name}"),
                                              actions: [
                                                ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor: Colors.red,
                                                  ),
                                                  onPressed: () async {
                                                    store.deleteProduct(
                                                      id: store
                                                          .filteredProducts[
                                                              index]
                                                          .id!,
                                                      context: context,
                                                    );
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                    "Deletar",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          "Deletar",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                        ),
                                        onPressed: () async {
                                          store.updateProduct(
                                            product: store
                                                .filteredProducts[index]
                                                .copyWith(
                                              amount: amount,
                                              isPurchased: isPurchased,
                                              name: name,
                                              price: price,
                                            ),
                                            context: context,
                                          );
                                          Modular.to.pop();
                                        },
                                        child: const Text(
                                          "Salvar",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                              trailing: Container(
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: store.filteredProducts[index]
                                              .isPurchased ==
                                          true
                                      ? Colors.green
                                      : Colors.grey,
                                  borderRadius: BorderRadius.circular(
                                    30,
                                  ),
                                ),
                                child: Icon(
                                  store.filteredProducts[index].isPurchased ==
                                          true
                                      ? Icons.add_shopping_cart
                                      : Icons.remove_shopping_cart,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                  "Nome: ${store.filteredProducts[index].name!}"),
                              subtitle:
                                  store.filteredProducts[index].isPurchased ==
                                          false
                                      ? null
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                "Quantidade: ${store.filteredProducts[index].amount!}"),
                                            Text(
                                                "preço: ${UtilBrasilFields.obterReal(store.filteredProducts[index].price!)}"),
                                          ],
                                        ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ],
            ),
          )),
    );
  }
}
