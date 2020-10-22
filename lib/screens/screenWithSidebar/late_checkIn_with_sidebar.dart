import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/screen/late_checkIn_screen.dart';
import 'package:provider_flutter_application/screens/side_bar/side_bar.dart';

class LateCheckInWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: lateCheckInWithSidebar(),
    );
  }
}

class lateCheckInWithSidebar extends StatefulWidget {
  @override
  _lateCheckInWithSidebarState createState() => _lateCheckInWithSidebarState();
}

class _lateCheckInWithSidebarState extends State<lateCheckInWithSidebar>{

  @override
  Widget build(BuildContext context) {
    return SideBar(screen: LateCheckInScreen());
  }
}
