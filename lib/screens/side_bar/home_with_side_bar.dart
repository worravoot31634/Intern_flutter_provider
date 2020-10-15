import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../article_screen.dart';
import '../home_screen.dart';
import 'package:provider_flutter_application/global.dart';

class HomeWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: homeWithSidebar(),
    );
  }
}

class homeWithSidebar extends StatefulWidget {
  @override
  _homeWithSidebarState createState() => _homeWithSidebarState();
}

class _homeWithSidebarState extends State<homeWithSidebar>
    with TickerProviderStateMixin {
  bool sideBarActive = false;
  AnimationController rotationController;
  BorderRadius sidebarRadius = BorderRadius.all(Radius.circular(0));

  final screen = HomeScreen();


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
                    height: 130,
                    width: MediaQuery.of(context).size.width * 0.6,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(60)),
                        color: Colors.red[800]),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/avatar4.png'),
                                  fit: BoxFit.contain),
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Carol Johnson",
                                style: TextStyle(
                                    fontSize: 19, fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Seattle Washington",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                              )
                            ],
                          )
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
                    navigatorTitle("Home", true),
                    navigatorTitle("Profile", false),
                    InkWell(
                        onTap: () {
                          closeSideBar();
                          Get.toNamed('article');
                        },
                        child: navigatorTitle("Article", false)),
                    navigatorTitle("Transactions", false),
                    navigatorTitle("Stats", false),
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
                  "Ver ${Global.APP_VERSION}",
                  style: TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 200),
            left: (sideBarActive) ? MediaQuery.of(context).size.width * 0.5 : 0,
            top:
                (sideBarActive) ? MediaQuery.of(context).size.height * 0.15 : 0,
            child: RotationTransition(
              turns: (sideBarActive)
                  ? Tween(begin: -0.00, end: 0.0).animate(rotationController)
                  : Tween(begin: 0.0, end: -0.00).animate(rotationController),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 200),
                height: (sideBarActive)
                    ? MediaQuery.of(context).size.height * 0.8
                    : MediaQuery.of(context).size.height,
                width: (sideBarActive)
                    ? MediaQuery.of(context).size.width * 0.8
                    : MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: sidebarRadius,
                    color: Colors.white),
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
                      margin: EdgeInsets.all(17),
                      height: 50,
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
              fontSize: 16,
              fontWeight: (isSelected) ? FontWeight.w700 : FontWeight.w400),
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
    sidebarRadius = BorderRadius.all(Radius.circular(40));
    setState(() {});
  }
}
