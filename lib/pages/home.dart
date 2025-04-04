import 'package:flutter/material.dart';

import '../widgets/main_map.dart';

class HomePage extends StatelessWidget {
  static const route = "/";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MainMap();
  }
}
