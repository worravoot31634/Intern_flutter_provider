import 'dart:async';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:provider_flutter_application/animation/LoadingCubeGridAnimation.dart';
import 'package:provider_flutter_application/animation/LoadingRippleAnimation.dart';
import 'package:provider_flutter_application/api/base_model.dart';
import 'package:provider_flutter_application/api/user_api/work_hours_api.dart';

import 'package:provider_flutter_application/model/work_hours.dart';
import 'package:location/location.dart';
import 'package:provider_flutter_application/provider/home_provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:provider/provider.dart';

import 'article_screen.dart';
import 'side_bar/home_with_side_bar.dart';
import 'late_checkIn_screen.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: _HomeScreen(), debugShowCheckedModeBanner: false);
  }
}

// ignore: must_be_immutable
class _HomeScreen extends StatelessWidget {
  //Google Map
  Completer<GoogleMapController> _controller = Completer();
  LocationData currentLocation;

  //Notification
  String message = 'No message.';
  String channelId;
  String channelName = 'FLUTTER_NOTIFICATION_CHANNEL';
  String channelDescription = 'FLUTTER_NOTIFICATION_CHANNEL_DETAIL';

  double latitude;
  double longitude;
  String id;
  String userAgent;
  String ipAddress;

  @override
  Widget build(BuildContext context) {
    log('Build at ' + DateTime.now().toString(),name: '[Home Screen]');
    //final state = context.watch<HomeProvider>();


    var initializationSettingsAndroid = AndroidInitializationSettings('logo');

    var initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification: (id, title, body, payload) {
          print("onDidReceiveLocalNotification called. $payload");
          return null;
        });
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (payload) {
          // when user tap on notification.
          print("onSelectNotification called.");
          return null;
        });

    return Consumer<HomeProvider>(
        builder: (BuildContext context, states, Widget child) {
          id = states.id;
          userAgent = states.userAgent;
          ipAddress = states.ipAddress;

          return Scaffold(
          body: states.initLoading
              ? LoadingCubeGrid()
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              "assets/images/logo.png",
                              width: 50,
                              height: 50,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Row(
                              children: [
                                Text(
                                  "Cube SoftTech",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'ubuntu',
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                            Stack(
                              children: [
                                Icon(
                                  Icons.notifications,
                                  color: Colors.black,
                                  size: 30,
                                ),
                                Container(
                                  width: 30,
                                  height: 30,
                                  alignment: Alignment.topRight,
                                  margin: EdgeInsets.only(top: 5),
                                  child: Container(
                                    width: 15,
                                    height: 15,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xffc32c37),
                                        border: Border.all(color: Colors.white, width: 1)),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Center(
                                        child: Text(
                                          '2',
                                          style: TextStyle(fontSize: 10,color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            Image.asset(
                              "assets/images/menu.png",
                              height: 22,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Hi, ' +
                              (states.nameStr == null
                                  ? 'wait'
                                  : states.nameStr),
                          style: TextStyle(
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    states.timeStr == null
                                        ? 'wait'
                                        : '${states.timeStr}',
                                    style: TextStyle(
                                        fontSize: 34,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    states.dateStr == null
                                        ? 'wait'
                                        : states.dateStr,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Container(
                                height: 60,
                                width: 120,
                                child: Center(
                                  child: states.btnStatus == 'check-in'
                                      ? RaisedButton(
                                    onPressed: () async {

                                          states.setCurrentLocation();

                                      currentLocation =
                                      await getCurrentLocation();
                                      latitude =
                                          currentLocation.latitude;
                                      longitude =
                                          currentLocation.longitude;
                                      return alertCheck(
                                          context, "Check In")
                                          .show();
                                    },
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(18.0),
                                    ),
                                    color: Colors.green,
                                    child: Center(
                                      child: Text(
                                        'Check In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                  )
                                      : states.btnStatus == 'finished-working'
                                      ? Text(
                                    'Finished!',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 19,
                                    ),
                                  )
                                      : states.btnStatus == null
                                      ? new LoadingRipple()
                                      : RaisedButton(
                                    onPressed: () async {
                                      states.setCurrentLocation();


                                      currentLocation =
                                      await getCurrentLocation();
                                      latitude = currentLocation
                                          .latitude;
                                      longitude =
                                          currentLocation
                                              .longitude;
                                      return alertCheck(context,
                                          'Check Out')
                                          .show();
                                    },
                                    shape:
                                    RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          18.0),
                                    ),
                                    color: Colors.blue,
                                    child: Center(
                                      child: Text(
                                        'Check Out',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight:
                                          FontWeight.w500,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
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
                                  Container(
                                    child: Text(
                                      "Last Check-in: ",
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
                                  Container(
                                    child: states.lastDateCheckInStr == null
                                        ? new SpinKitFadingCircle(
                                        color: Colors.white, size: 19)
                                        : Text(
                                      '${states.lastDateCheckInStr}',
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                      color: Colors.red[500],
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
                            Text(
                              'Menu',
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
                              serviceWidget('question.png', 'Work\nHistory'),
                              serviceWidget('question.png', 'Check\nList'),
                              serviceWidget('question.png', 'Travel\n'),
                              serviceWidget('question.png', 'SideBarTest\n'),
                              serviceWidget('question.png', 'Map\n'),
                              serviceWidget('more.png', 'More\n'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

              ],
            ),
          )
          );
          },
        );


  }

  Column serviceWidget(String img, String name) {
    log('name is $name', name: 'serviceWidget');
    return Column(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              switch (name) {
                case "Late\nCheck In":
                  {
                    log("Late Check In click");
                    //Get.toNamed('lateCheckIn');
                    //Get.toNamed('lateCheckIn');
                  }
                  break;

                case "Article\n":
                  {
                    print("Article click");
                    Get.toNamed('article');
                    //Get.toNamed('article');
                  }
                  break;

                case "Map\n":
                  {
                    print('Map clicked');
                    Get.toNamed('sideBar',arguments: HomeWithSidebar());
                    //Get.toNamed('menu');
                  }
                  break;
                case "SideBarTest\n":
                  {
                    print('SideBarTest clicked');
                    Get.toNamed('sideBar',arguments: ArticlePage());
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
        Text(
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
          Text(
            name,
            style: TextStyle(
                fontSize: 16,
                fontFamily: 'avenir',
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    try {
      return await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        log("Permission denied");
      }
      return null;
    }
  }

  Alert alertCheck(BuildContext context, String typeCheck) {
    log('[lat]: $latitude');
    log('[long]: $longitude');
    String checkInType;
    if (typeCheck == "Check In") {
      //case CheckIn
      checkInType = "1";
    } else if (typeCheck == "Check Out") {
      //case CheckOut
      checkInType = "2";
    } else {
      //Error something
      checkInType = "0";
    }


    return Alert(
      context: context,
      style: AlertStyle(
        animationType: AnimationType.fromTop,
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      content: Container(
        height: 200,
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: CameraPosition(
            target: LatLng(latitude ?? 0, longitude ?? 0),
            zoom: 20,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: {
            Marker(
              markerId: MarkerId("1"),
              position: LatLng(latitude ?? 0, longitude ?? 0),
            ),
          },
        ),
      ),
      title: '$typeCheck',
      // content: ,
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
            Navigator.of(context, rootNavigator: true).pop();
            log("cancel");
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
            log('$typeCheck : yes');

            WorkHoursApi workHoursApi = new WorkHoursApi();
            WorkHours workHours = new WorkHours();
            workHours.userCreate = id;
            workHours.workHoursType = checkInType;
            workHours.latitude = latitude.toString();
            workHours.longitude = longitude.toString();
            //workHours.description = description;
            workHours.userAgent = userAgent;
            workHours.ipAddress = ipAddress;
            // workHours.timeCreate = timeCreate;
            // workHours.wo = workingHours;
            //log("DATA: " + workHours.toJson().toString());
            BaseModel<String> status =
            await workHoursApi.checkInAndOut(workHours);
            //log("status: " + status.data.toString());
            //_getTodayCheckInById();

            if (status.data == "success") {
              log("status: " + status.data);
              sendNotification(int.parse(checkInType), typeCheck);
              context.read<HomeProvider>().updateButton();
              context.read<HomeProvider>().setLastCheckIn();
              //_refreshButtonCheckIn();
            }
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );
  }

  sendNotification(int id, String actionType) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channelId, channelName, channelDescription,
        importance: Importance.Max, priority: Priority.High);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    DateFormat formatter = DateFormat('d MMMM yyyy HH:mm');
    String formatted = formatter.format(DateTime.now());
    await flutterLocalNotificationsPlugin.show(
        id,
        'Cube SoftTech Notifications',
        'You $actionType at $formatted',
        platformChannelSpecifics,
        payload: 'I just haven\'t Met You Yet');
  }
}
