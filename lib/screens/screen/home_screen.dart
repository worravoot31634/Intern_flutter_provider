import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/animation/LoadingCubeGridAnimation.dart';
import 'package:provider_flutter_application/animation/LoadingRippleAnimation.dart';
import 'package:provider_flutter_application/provider/home_provider.dart';
import 'package:provider_flutter_application/screens/widgets/header_app.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _HomeScreen(), debugShowCheckedModeBanner: false);
  }
}

class _HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    log('Build at ' + DateTime.now().toString(), name: '[Home Screen]');
    return Consumer<HomeProvider>(
      builder: (BuildContext context, states, Widget child) {
        return Scaffold(
          body: (states.initLoading)
              ? LoadingCubeGrid() //Scaffold
              : Container(
                  child: Stack(
                    children: [
                      Container(
                        color: Colors.grey[100],
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
                            AutoSizeText(
                              'Hi, ' +
                                  (states.nameStr == null
                                      ? 'wait'
                                      : states.nameStr),
                              maxLines: 1,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 21,
                                  fontWeight: FontWeight.w800,
                                  fontFamily: 'avenir'),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: EdgeInsets.all(25),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                                color: Colors.grey[300],
                              ),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              states.timeStr == null
                                                  ? 'wait'
                                                  : '${states.timeStr}',
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 34,
                                                  fontWeight: FontWeight.w700),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            AutoSizeText(
                                              states.dateStr == null
                                                  ? 'wait'
                                                  : states.dateStr,
                                              maxLines: 1,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        padding: EdgeInsets.only(left: 20),
                                        height: 60,
                                        // width: MediaQuery.of(context).size.width * 0.3/*120*/,
                                        child: Center(
                                          child: (states.btnStatus ==
                                                  'check-in')
                                              ? RaisedButton(
                                                  onPressed: () async {
                                                    states.setCurrentLocation();
                                                    return alertCheck(
                                                            context, "Check In")
                                                        .show();
                                                  },
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ),
                                                  color: Colors.green,
                                                  child: Center(
                                                    child: AutoSizeText(
                                                      'Check In',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 19,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : (states.btnStatus ==
                                                      'finished-working')
                                                  ? AutoSizeText(
                                                      'Finished!',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        color: Colors.red,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        fontSize: 19,
                                                      ),
                                                    )
                                                  : (states.btnStatus == null)
                                                      ? new LoadingRipple()
                                                      : RaisedButton(
                                                          onPressed: () async {
                                                            // states
                                                            //     .setCurrentLocation();

                                                            return alertCheck(
                                                                    context,
                                                                    'Check Out')
                                                                .show();
                                                          },
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        18.0),
                                                          ),
                                                          color: Colors.blue,
                                                          child: Center(
                                                            child: AutoSizeText(
                                                              'Check Out',
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 19,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Container(
                                          child: AutoSizeText(
                                            "Last Check-in: ",
                                            maxLines: 1,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),
                                            color: Colors.grey[500],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Container(
                                          child: (states.lastDateCheckInStr ==
                                                  null)
                                              ? new SpinKitFadingCircle(
                                                  color: Colors.white, size: 19)
                                              : AutoSizeText(
                                                  '${states.lastDateCheckInStr}',
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10)),
                                            color: Colors.red[500],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                AutoSizeText(
                                  'Menu',
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w800,
                                      fontFamily: 'avenir'),
                                ),
                                Container(
                                  height: 60,
                                  width: 60,
                                  child: Icon(Icons.dialpad),
                                )
                              ],
                            ),
                            Expanded(
                              child: GridView.count(
                                crossAxisCount: 4,
                                childAspectRatio: 0.7,
                                children: [
                                  serviceWidget(
                                      'clock_black.png', 'Late\nCheck In'),
                                  serviceWidget('document.png', 'Article\n'),
                                  // serviceWidget(
                                  //     'question.png', 'Work\nHistory'),
                                  // serviceWidget('question.png', 'Check\nList'),
                                  // serviceWidget('question.png', 'Travel\n'),
                                  // serviceWidget(
                                  //     'question.png', 'xxx\n'),
                                  // serviceWidget('question.png', 'Map\n'),
                                  // serviceWidget('more.png', 'More\n'),
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
      },
    );
  }

  Column serviceWidget(String img, String name) {
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              switch (name) {
                case "Late\nCheck In":
                  {
                    print("Late Check In click");
                    Get.toNamed('lateCheckIn');
                  }
                  break;

                case "Article\n":
                  {
                    log('open article screen');
                    Get.toNamed('article');
                  }
                  break;
                default:
                  {
                    print("default");
                  }
                  break;
              }
            },
            child: Container(
              margin: EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                color: Colors.grey[300],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[300],
                    blurRadius: 10.0,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$img'),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 5,
        ),
        AutoSizeText(
          name,
          style: TextStyle(
            fontFamily: 'avenir',
            fontSize: 14,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Container avatarWidget(String img, String name) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      height: 150,
      width: 120,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          color: Color(0xfff1f3f6)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage('assets/images/$img'),
                    fit: BoxFit.contain),
                border: Border.all(color: Colors.black, width: 2)),
          ),
          AutoSizeText(
            name,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }


  Alert alertCheck(BuildContext context, String typeCheck) {
    String checkInType;

    if (typeCheck == "Check In") {
      //Case Check-In
      checkInType = "1";
    } else if (typeCheck == "Check Out") {
      //CASE Check-Out
      checkInType = "2";
    } else {
      //Error something
      checkInType = "0";
    }
    return Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.grow,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      content: Consumer<HomeProvider>(
        builder: (BuildContext context, states, Widget child) => Container(
          height: 200,
          child: ((states.latitude == null) && (states.longitude == null))
              ? new LoadingRipple()
              : GoogleMap(
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(states.latitude ?? 0, states.longitude ?? 0),
                    zoom: 20,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    states.mapController.complete(controller);
                  },
                ),
        ),
      ),
      title: '$typeCheck',
      buttons: [
        DialogButton(
          child: Text(
            "Cancel",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          color: Colors.grey,
          onPressed: () {
            Get.back();
          },
        ),
        DialogButton(
          child: Text(
            "Yes",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          color: Colors.green,
          onPressed: () async {
            context.read<HomeProvider>().confirmCheckIn(checkInType: checkInType);
          },
        ),
      ],
    );
  }
}
