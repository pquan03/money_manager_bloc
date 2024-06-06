import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:money_manager/blocs/main/main_cubit.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = 'setting_screen';

  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: BlocBuilder<MainCubit, MainState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(child: Text('Dark Mode')),
                  SizedBox(
                    width: 150,
                    child: DropdownButton<bool>(
                        value: state.isLightTheme,
                        items: const [
                          DropdownMenuItem(
                            value: true,
                            child: Text('Light Theme'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('Dark Theme'),
                          ),
                        ],
                        onChanged: (value) {
                          context.read<MainCubit>().setTheme(value!);
                        }),
                  )
                ],
              )
            ],
          ),
        );
      },
    ));
  }
}
