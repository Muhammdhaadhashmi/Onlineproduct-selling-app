import 'package:flutter/material.dart';
import 'package:onicame/screen/Pages/Home/home_page.dart';
import 'package:onicame/utils/enums.dart';

import 'widgets/navigation_bar.dart';

class AppView extends StatefulWidget {
  @override
  _AppViewState createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: const DrawerMenu(),
      body: Column(
        children: [
          const NavContainer(select: MenuState.home),
          Expanded(child: HomePage()),
        ],
      ),
    );
  }
}
