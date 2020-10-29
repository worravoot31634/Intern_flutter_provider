import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider_flutter_application/api/user_api/ticket_api.dart';
import 'package:provider_flutter_application/model/ticket.dart';
import 'package:provider_flutter_application/screens/widgets/header_app.dart';

class TicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _TicketScreen(),
    );
  }
}

class _TicketScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('Build at ' + DateTime.now().toString(), name: '[Ticket Screen]');
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.grey[100],
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerApp(),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.bug_report,
                        size: 22,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      AutoSizeText(
                        "Ticket",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'avenir'),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton.icon(
                          onPressed: () async{
                            Get.toNamed('addTicket');
                            TicketApi ticketApi = new TicketApi();
                            List<Ticket> ticketList = await ticketApi.getAllTicket();
                            },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10.0))),
                          label: AutoSizeText('Add', style: TextStyle(color: Colors.white),
                          ),
                          icon: Icon(
                            Icons.add_box,
                            color: Colors.white,
                          ),
                          textColor: Colors.white,
                          color: Colors.green,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

String dateStrToDateTime(String strDateTime) {
  DateTime oldFormat =
      new DateFormat("MMM dd, yyyy hh:mm:ss a").parse(strDateTime);
  String newFormat = DateFormat("d MMM yyyy HH:mm").format(oldFormat);

  return newFormat;
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
