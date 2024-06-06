

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/widgets/main_app.dart';
import 'package:money_manager/widgets/screens/add_edit/add_edit_screen.dart';
import 'package:money_manager/widgets/screens/detail/detail_screen.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_cubit.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';
import 'package:money_manager/widgets/screens/login/login_screen.dart';
import 'package:money_manager/widgets/screens/menu/menu_screen.dart';
import 'package:money_manager/widgets/screens/setting/settting_screen.dart';

Route<dynamic>? mainRoute(RouteSettings settings) {
  switch(settings.name) {
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
    case ListItemScreen.routeName:
      return MaterialPageRoute(builder: (_) => const ListItemScreen());
    case DetailScreen.routeName:
      var cubit = (settings.arguments as Map<String, dynamic>)['cubit'] as ListItemCubit;
      return MaterialPageRoute(builder: (_) => BlocProvider<ListItemCubit>.value(
        value: cubit,
        child: const DetailScreen(),
      ));
    case AddEditScreen.routeName:
      var cubit = (settings.arguments as Map<String, dynamic>)['cubit'] as ListItemCubit;
      var isAddMode = (settings.arguments as Map<String, dynamic>)['isAddMode'] as bool?;
      return MaterialPageRoute(builder: (_) => BlocProvider<ListItemCubit>.value(
        value: cubit,
        child: AddEditScreen(isAddMode: isAddMode ?? true),
      ));
    case MenuScreen.routeName:
      return MaterialPageRoute(builder: (_) => const MenuScreen());
    case SettingScreen.routeName:
      return MaterialPageRoute(builder: (_) => const SettingScreen());
    case MainApp.routeName:
      return MaterialPageRoute(builder: (_) => const MainApp());
    default:
      return MaterialPageRoute(builder: (_) => const LoginScreen());
  }
}
