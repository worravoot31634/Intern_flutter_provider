

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_flutter_application/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SideBar extends StatelessWidget {
  final Widget screen;

  SideBar({this.screen});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _SideBar(screen: screen),
    );
  }
}

class _SideBar extends StatefulWidget {
  final Widget screen;

  _SideBar({this.screen});

  @override
  _SideBarState createState() => _SideBarState(screen: screen);
}

class _SideBarState extends State<_SideBar> with TickerProviderStateMixin {
  bool sideBarActive = false;
  AnimationController rotationController;
  BorderRadius sidebarRadius = BorderRadius.all(Radius.circular(0));

  final Widget screen;

  _SideBarState({this.screen});

  @override
  void initState() {
    rotationController =
        AnimationController(duration: Duration(milliseconds: 200), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                          //       "Carol Johnson",
                          //       style: TextStyle(
                          //           fontSize: 19, fontWeight: FontWeight.w700),
                          //     ),
                          //     Text(
                          //       "Seattle Washington",
                          //       style: TextStyle(
                          //           fontSize: 13,
                          //           fontWeight: FontWeight.w400,
                          //           color: Colors.grey),
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
                child: Container(
                  //height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                          onTap: () {
                            if (Get.currentRoute != 'home') {

                              Get.offNamed('home');
                            } else {
                              closeSideBar();
                            }
                          },
                          child: navigatorTitle(
                              "Home", Icons.home_outlined, true)),
                      InkWell(
                          onTap: () {},
                          child: navigatorTitle(
                              "Profile", Icons.person_outlined, false)),
                      InkWell(
                          onTap: () {},
                          child: navigatorTitle(
                              "Settings", Icons.tune_outlined, false)),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                  print('logout');
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.clear();
                  //context.read<HomeProvider>().dispose();
                  Get.offAllNamed('/login');
                },
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Icon(
                        Icons.power_settings_new,
                        size: 30,
                        color: Colors.red[800],
                      ),
                      SizedBox(
                        width: 10,
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
                  "Ver ${Global.APP_VERSION}",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: (sideBarActive) ? MediaQuery.of(context).size.width * 0.7 : 0,
            top:
                (sideBarActive) ? MediaQuery.of(context).size.height * 0.15 : 0,
            child: RotationTransition(
              turns: (sideBarActive)
                  ? Tween(begin: -0.00, end: 0.0).animate(rotationController)
                  : Tween(begin: 0.0, end: -0.00).animate(rotationController),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: (sideBarActive)
                    ? MediaQuery.of(context).size.height * 0.7
                    : MediaQuery.of(context).size.height,
                width: (sideBarActive)
                    ? MediaQuery.of(context).size.width * 1
                    : MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: sidebarRadius, color: Colors.white),
                child: InkWell(
                  onTap: closeSideBar,
                  child: ClipRRect(
                    borderRadius: sidebarRadius,
                    child: screen,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 20,
            child: (sideBarActive)
                ? IconButton(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    padding: EdgeInsets.all(30),
                    onPressed: closeSideBar,
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 30,
                    ),
                  )
                : InkWell(
                    onTap: openSideBar,
                    child: Container(
                      margin: EdgeInsets.all(30),
                      height: 22,
                      // decoration: BoxDecoration(
                      //     image: DecorationImage(
                      //   image: AssetImage(
                      //     'assets/images/menu.png',
                      //   ),
                      // )),
                    ),
                  ),
          )
        ],
      ),
    );
  }

  Row navigatorTitle(String menuName, IconData iconImg, bool isSelected) {
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
          width: 20,
          height: 60,
        ),
        Icon(
          iconImg,
          size: 25,
          color: Colors.red[800],
        ),
        SizedBox(
          width: 15,
          height: 60,
        ),
        AutoSizeText(
          menuName,
          style: TextStyle(
              fontSize: 18,
              fontWeight: (isSelected) ? FontWeight.bold : FontWeight.w400),
        )
      ],
    );
  }

  void closeSideBar() {
    sideBarActive = false;
    sidebarRadius = BorderRadius.all(Radius.circular(0));
    setState(() {});
  }

  void openSideBar() {
    sideBarActive = true;
    sidebarRadius = BorderRadius.all(Radius.circular(30));
    setState(() {});
  }
}
