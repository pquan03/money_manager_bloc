import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/blocs/main/main_cubit.dart';

import '../../../common/drawer_item.dart';

class MenuScreen extends StatelessWidget {
  static const String routeName = 'menu_screen';

  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Page();
  }
}

class Page extends StatelessWidget {
  const Page({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<MainCubit, MainState>(
        builder: (context, state) {
          return Column(
            children: [
              ListTile(
                selectedColor: state.selected == DrawerItem.home ? Colors.blue : null,
                selectedTileColor: state.selected == DrawerItem.home ? Colors.white : null,
                title: const Text('Home'),
                trailing: state.selected != DrawerItem.home ? const Icon(Icons.navigate_next) : null,
                onTap: () {
                  context.read<MainCubit>().setSelected(DrawerItem.home);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                selectedColor: state.selected == DrawerItem.setting ? Colors.blue : null,
                selectedTileColor: state.selected == DrawerItem.setting ? Colors.white : null,
                title: const Text('Settings'),
                trailing: state.selected != DrawerItem.setting ? const Icon(Icons.navigate_next) : null,
                onTap: () {
                  context.read<MainCubit>().setSelected(DrawerItem.setting);
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
