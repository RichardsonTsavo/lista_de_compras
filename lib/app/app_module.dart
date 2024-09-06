import 'package:flutter_modular/flutter_modular.dart';
import 'package:lista_de_compras/app/modules/editList/editList_module.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/', module: HomeModule()),
    ModuleRoute('/editList', module: EditListModule()),
  ];
}
