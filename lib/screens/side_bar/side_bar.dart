import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/global.dart';
import 'package:provider_flutter_application/provider/side_bar/side_bar_provider.dart';

class SideBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _SideBar(
        screen: Get.arguments != null ? _SideBar(screen: Get.arguments) : Text('ERROR send Data!'),
      ),
    );
  }
}

class _SideBar extends StatefulWidget {
  final Widget screen;

  const _SideBar({Key key, this.screen}) : super(key: key);

  @override
  _SidebarState createState() => _SidebarState(screen: screen);
}

class _SidebarState extends State<_SideBar> with TickerProviderStateMixin {

  AnimationController rotationController;
  // BorderRadius sidebarRadius = BorderRadius.all(Radius.circular(0));
  final Widget screen;

  _SidebarState({this.screen});

  @override
  void initState() {
    log('OBJECT SCREEN: $screen');
    context.read<SideBarProvider>().setScreen(screen);
    rotationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final state = context.watch<SideBarProvider>();
    return Consumer<SideBarProvider>(
        builder: (BuildContext context, states, Widget child){
          return Scaffold(
        backgroundColor: Colors.grey[300],
        body: Stack(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 120,
                      width: MediaQuery.of(context).size.width * 0.5,
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.only(bottomRight: Radius.circular(60)),
                          color: Colors.red[800]),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/avatar4.png'),
                                    fit: BoxFit.contain),
                              ),
                            ),
                            // SizedBox(
                            //   width: 10,
                            // ),
                            // Column(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   crossAxisAlignment: CrossAxisAlignment.start,
                            //   children: [
                            //     Text(
                            //       'Worrawoot',
                            //       style: TextStyle(
                            //           fontSize: 19, fontWeight: FontWeight.w700,color: Colors.white),
                            //     ),
                            //     Text(
                            //       "IT",
                            //       style: TextStyle(
                            //           fontSize: 15,
                            //           fontWeight: FontWeight.w400,
                            //           color: Colors.white),
                            //     )
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () => Get.toNamed('home'),
                          child: navigatorTitle("Home", true)),
                      navigatorTitle("Profile", false),

                      navigatorTitle("Settings", false),
                      navigatorTitle("Help", false),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    print('logout');
                    Get.toNamed('/');
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Icon(
                          Icons.power_settings_new,
                          size: 30,
                        ),
                        Text(
                          "Logout",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "version: ${Global.APP_VERSION}",
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              left: (states.sideBarActive) ? MediaQuery.of(context).size.width * 0.4 : 0,
              top:
                  (states.sideBarActive) ? MediaQuery.of(context).size.height * 0.15 : 0,
              child: RotationTransition(
                turns: (states.sideBarActive)
                    ? Tween(begin: -0.00, end: 0.0).animate(rotationController)
                    : Tween(begin: 0.0, end: -0.00).animate(rotationController),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  height: (states.sideBarActive)
                      ? MediaQuery.of(context).size.height * 0.8
                      : MediaQuery.of(context).size.height,
                  width: (states.sideBarActive)
                      ? MediaQuery.of(context).size.width * 0.8
                      : MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: states.sideBarRadius,
                      color: Colors.white),
                  child:  InkWell(
                        onTap: states.closeSideBar,
                        child: ClipRRect(
                          borderRadius: states.sideBarRadius,
                          child: states.screen,
                        ),
                      ),

                  ),
                ),
              ),

            Positioned(
              right: 0,
              top: 20,
              child: (states.sideBarActive)
                  ? IconButton(
                      padding: EdgeInsets.all(30),
                      onPressed: states.closeSideBar,
                      icon: Icon(
                        Icons.close,
                        color: Colors.black,
                        size: 30,
                      ),
                    )
                  : InkWell(
                      onTap: states.openSideBar,
                      child: Container(
                        margin: EdgeInsets.all(30),
                        height: 22,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            'assets/images/menu.png',
                          ),
                        )),
                      ),
                    ),
            )
          ],
        ),
      );
                    },
    );
  }

  Row navigatorTitle(String name, bool isSelected) {
    return Row(
      children: [
        (isSelected)
            ? Container(
                width: 5,
                height: 60,
                color: Color(0xffffac30),
              )
            : Container(
                width: 5,
                height: 60,
              ),
        SizedBox(
          width: 10,
          height: 60,
        ),
        Text(
          name,
          style: TextStyle(
              fontSize: 18,
              fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400),
        )
      ],
    );
  }

  // void closeSideBar() {
  //   log('closeSideBar', name: 'SideBar');
  //   sideBarActive = false;
  //   sidebarRadius = BorderRadius.all(Radius.circular(0));
  //   setState(() {});
  // }
  //
  // void openSideBar() {
  //   log('openSideBar', name: 'SideBar');
  //   sideBarActive = true;
  //   sidebarRadius = BorderRadius.all(Radius.circular(40));
  //   setState(() {});
  // }
}
