import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_de_compras/app/modules/editList/editList_page.dart';
import 'package:lista_de_compras/app/modules/editList/editList_store.dart';

class EditListModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => EditListStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/',
        child: (_, args) => EditListPage(
              shoppingListModel: args.data,
            )),
  ];
}
