








import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  static const String routeName = 'detail_screen';
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(routeName),
      ),
    );
  }
}
