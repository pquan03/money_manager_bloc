










import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  static const String routeName = 'menu_screen';
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(routeName),
      ),
    );
  }
}
