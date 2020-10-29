import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/screen/ticket_screen.dart';
import 'package:provider_flutter_application/screens/side_bar/side_bar.dart';

class TicketWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ticketWithSidebar(),
    );
  }
}

class ticketWithSidebar extends StatefulWidget {
  @override
  _ticketWithSidebarState createState() => _ticketWithSidebarState();
}

class _ticketWithSidebarState extends State<ticketWithSidebar>{

  @override
  Widget build(BuildContext context) {
    return SideBar(screen: TicketScreen());
  }
}
