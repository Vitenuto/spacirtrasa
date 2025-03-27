import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Home Page"));
  }
}
