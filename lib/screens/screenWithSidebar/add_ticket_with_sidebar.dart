import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/screen/add_ticket_screen.dart';
import 'package:provider_flutter_application/screens/side_bar/side_bar.dart';

class AddTicketWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _AddTicketWithSidebar(),
    );
  }
}

class _AddTicketWithSidebar extends StatefulWidget {
  @override
  _AddTicketWithSidebarState createState() => _AddTicketWithSidebarState();
}

class _AddTicketWithSidebarState extends State<_AddTicketWithSidebar>{

  @override
  Widget build(BuildContext context) {
    return SideBar(screen: AddTicketScreen());
  }
}
