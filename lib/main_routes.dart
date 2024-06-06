

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manager/widgets/screens/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/screens/detail/detail_screen.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';
import 'package:money_manager/widgets/screens/login/login_screen.dart';
import 'package:money_manager/widgets/screens/menu/menu_screen.dart';
import 'package:money_manager/widgets/screens/setting/settting_screen.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  return switch(settings.name) {
    LoginScreen.routeName => MaterialPageRoute(builder: (_) => const LoginScreen()),
    ListItemScreen.routeName => MaterialPageRoute(builder: (_) => const ListItemScreen()),
    DetailScreen.routeName => MaterialPageRoute(builder: (_) => const DetailScreen()),
    AddEditScreen.routeName => MaterialPageRoute(builder: (_) => const AddEditScreen()),
    MenuScreen.routeName => MaterialPageRoute(builder: (_) => const MenuScreen()),
    SettingScreen.routeName => MaterialPageRoute(builder: (_) => const SettingScreen()),
    _ => MaterialPageRoute(builder: (_) => const LoginScreen()),
  };
}
