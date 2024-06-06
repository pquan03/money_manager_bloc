










import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  static const String routeName = 'setting_screen';
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(routeName),
      ),
    );
  }
}
