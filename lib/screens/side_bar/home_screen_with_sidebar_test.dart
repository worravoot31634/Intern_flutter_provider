import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/side_bar/sidebar_test.dart';
import 'package:provider_flutter_application/screens/test_screen/home_screen_test.dart';
import '../home_screen.dart';

class HomeWithSidebarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeWithSidebarTest(),
    );
  }
}

class homeWithSidebarTest extends StatefulWidget {
  @override
  _homeWithSidebarStateTest createState() => _homeWithSidebarStateTest();
}

class _homeWithSidebarStateTest extends State<homeWithSidebarTest>{

  @override
  Widget build(BuildContext context) {
    return SideBarTest(screen: HomeScreenTest());
  }
}
