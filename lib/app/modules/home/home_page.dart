import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_de_compras/app/shared/models/shopping_list_model.dart';

import '../../shared/utils/utils.dart';
import '../../shared/widgets/animated_list/animated_list_widget.dart';
import 'home_store.dart';

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({super.key, this.title = 'Lista de Compras'});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeStore store;

  @override
  void initState() {
    super.initState();
    store = Modular.get<HomeStore>();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            String nameShoppingList = "";
            Utils.showPopupDialog(
              context: context,
              child: AlertDialog(
                actionsAlignment: MainAxisAlignment.spaceEvenly,
                backgroundColor: Colors.white,
                title: const Text(
                  "Criar nova lista de compras",
                  textAlign: TextAlign.center,
                ),
                content: TextField(
                  cursorColor: Colors.black,
                  decoration: InputDecoration(
                    labelText: "Nome da Lista",
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
                    nameShoppingList = value;
                  },
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () async {
                      if (nameShoppingList.isNotEmpty) {
                        Navigator.of(context).pop();
                        await store.saveShoppingList(
                          ShoppingListModel(
                            id: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(),
                            name: nameShoppingList,
                            products: [],
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Adicione um nome ao produto'),
                          ),
                        );
                      }
                    },
                    child: const Text("Criar lista"),
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
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<ShoppingListModel>>(
            future: store.getShoppingList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                );
              }
              store.initShoppingList(snapshot.data!);
              return Column(
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
                          store.filteredShoppingList.length,
                          (index) => Card(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                onTap: () {
                                  Modular.to
                                      .pushNamed(
                                    '/editList/',
                                    arguments:
                                        store.filteredShoppingList[index],
                                  )
                                      .then((value) {
                                    if (value == true) {
                                      setState(() {});
                                    }
                                  });
                                },
                                trailing: IconButton(
                                  onPressed: () async {
                                    Utils.showPopupDialog(
                                      context: context,
                                      child: AlertDialog(
                                        actionsAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        backgroundColor: Colors.white,
                                        title: Text(
                                            "Deseja deletar Lista de compras ${store.filteredShoppingList[index].name}"),
                                        actions: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.red,
                                            ),
                                            onPressed: () async {
                                              store.deleteShoppingList(
                                                store
                                                    .filteredShoppingList[index]
                                                    .id!,
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
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ),
                                title: Text(
                                    store.filteredShoppingList[index].name!),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }
}
