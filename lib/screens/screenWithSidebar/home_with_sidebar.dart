import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/screen/home_screen.dart';
import 'package:provider_flutter_application/screens/side_bar/side_bar.dart';


class HomeWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeWithSidebar(),
    );
  }
}

class homeWithSidebar extends StatefulWidget {
  @override
  _homeWithSidebarStateTest createState() => _homeWithSidebarStateTest();
}

class _homeWithSidebarStateTest extends State<homeWithSidebar>{

  @override
  Widget build(BuildContext context) {
    return SideBar(screen: HomeScreen());
  }
}
