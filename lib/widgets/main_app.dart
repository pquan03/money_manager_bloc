import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/blocs/main/main_cubit.dart';
import 'package:money_manager/widgets/screens/list_item/list_item_screen.dart';
import 'package:money_manager/widgets/screens/menu/menu_screen.dart';
import 'package:money_manager/widgets/screens/setting/settting_screen.dart';

import '../common/drawer_item.dart';

class MainApp extends StatelessWidget {
  static const String routeName = 'main_app';
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: _buildTitle(state.selected),
          ),
          drawer: const Drawer(child: MenuScreen(),),
          body: _buildBody(context, state.selected)
        );
      },
    );
  }

  Widget _buildTitle(DrawerItem selected) {
    switch (selected) {
      case DrawerItem.home:
        return const Text('Money Manager');
      case DrawerItem.setting:
        return const Text('Settings');
      default:
        return const Text('Money Manager');
    }
  }

  
  Widget _buildBody(BuildContext context, DrawerItem selected) {
    switch (selected) {
      case DrawerItem.home:
        return const ListItemScreen();
      case DrawerItem.setting:
        return const SettingScreen();
      default:
        return const ListItemScreen();
    }
  }
}
