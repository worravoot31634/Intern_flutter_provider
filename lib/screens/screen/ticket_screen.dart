import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/animation/LoadingCubeGridAnimation.dart';
import 'package:provider_flutter_application/model/ticket.dart';
import 'package:provider_flutter_application/provider/ticket_provider.dart';
import 'package:provider_flutter_application/screens/widgets/header_app.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
                          onPressed: () async {
                            Get.toNamed('addTicket');
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          label: AutoSizeText(
                            'Add',
                            style: TextStyle(color: Colors.white),
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
            Consumer<TicketProvider>(
              builder: (BuildContext context, states, Widget child) =>
                  Container(
                padding: EdgeInsets.only(
                  top: 180.0,
                  left: 30.0,
                  right: 30.0,
                ),
                child: states.ticketScreenLoading
                    ? LoadingCubeGrid()
                    : SmartRefresher(
                        enablePullDown: true,
                        enablePullUp: true,
                        header: ClassicHeader(),
                        footer: CustomFooter(
                          builder: (BuildContext context, LoadStatus mode) {
                            Widget body;
                            if (mode == LoadStatus.idle) {
                              body = Text("pull up load");
                            } else if (mode == LoadStatus.loading) {
                              body = CupertinoActivityIndicator();
                            } else if (mode == LoadStatus.failed) {
                              body = Text("Load Failed!Click retry!");
                            } else if (mode == LoadStatus.canLoading) {
                              body = Text("more article");
                            } else {
                              body = Text("No more Data");
                            }
                            return Container(
                              height: 55.0,
                              child: Center(child: body),
                            );
                          },
                        ),
                        controller: states.refreshController,
                        onRefresh: states.onRefresh,
                        onLoading: states.onLoading,
                        child: Container(
                          child: ListView.builder(
                            itemCount: states.ticketListView.length > 10
                                ? states.countItemListTicket
                                : states.ticketListView.length,
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Get.toNamed('articleDetails',
                                      arguments: states.ticketListView[index]);
                                },
                                child: TicketTile(
                                  //Send List to Tile
                                  ticketList: states.ticketListView[index],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class TicketTile extends StatelessWidget {
  String ticketId;
  String ticketName;
  String timeCreate;
  String ticketStatusName;
  Ticket ticketList;
  Color bgProcessColor;
  Color textProcessColor;

  /// later can be changed with imgUrl
  TicketTile({this.ticketList});



  @override
  Widget build(BuildContext context) {
    //Initial Value
    ticketId = ticketList.ticketId.toString();
    ticketName = ticketList.ticketName;
    timeCreate = ticketList.timeCreate;
    ticketStatusName = ticketList.ticketStatusName;

    if(ticketList.ticketStatusId == 1){
      bgProcessColor = Colors.deepOrange[700];
      textProcessColor = Colors.white;
    }else if(ticketList.ticketStatusId == 2){
      bgProcessColor = Colors.grey[700];
      textProcessColor = Colors.white;
    }else if(ticketList.ticketStatusId == 3){
      bgProcessColor = Colors.green[700];
      textProcessColor = Colors.white;
    }
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xff29404E),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    '$ticketName',
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'prompt',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/clock.png",
                        height: 12,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      AutoSizeText(
                        '${dateStrToDateTime(timeCreate)}',
                        maxLines: 1,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontFamily: 'prompt',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: Container(
              width: 130,
              child: RaisedButton(
                onPressed: () {},
                color: bgProcessColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      bottomRight: Radius.circular(8)),
                ),
                child: Center(
                    child: AutoSizeText(
                  "$ticketStatusName",
                  maxLines: 1,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: textProcessColor),
                )),
              ),
            ),
          ),
        ],
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
