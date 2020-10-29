import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/screen/add_ticket_screen.dart';
import 'package:provider_flutter_application/screens/side_bar/side_bar.dart';

class AddTicketWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: addTicketWithSidebar(),
    );
  }
}

class addTicketWithSidebar extends StatefulWidget {
  @override
  _addTicketWithSidebarState createState() => _addTicketWithSidebarState();
}

class _addTicketWithSidebarState extends State<addTicketWithSidebar>{

  @override
  Widget build(BuildContext context) {
    return SideBar(screen: AddTicketScreen());
  }
}
