import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/provider/article_provider.dart';
import 'package:provider_flutter_application/provider/home_provider.dart';
import 'package:provider_flutter_application/provider/late_checkin_provider.dart';
import 'package:provider_flutter_application/provider/login_provider.dart';
import 'package:provider_flutter_application/provider/side_bar/header_app_provider.dart';
import 'package:provider_flutter_application/provider/side_bar/side_bar_provider.dart';
import 'package:provider_flutter_application/screens/article_details_screen.dart';
import 'package:provider_flutter_application/screens/article_screen.dart';
import 'file:///C:/Users/User/IdeaProjects/flutter_application_provider/lib/screens/side_bar/home_screen_with_sidebar_test.dart';
import 'package:provider_flutter_application/screens/late_checkIn_screen.dart';
import 'package:provider_flutter_application/screens/login_screen.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HeaderAppProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => LateCheckInProvider()),
        ChangeNotifierProvider(create: (_) => SideBarProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),

      getPages: [
        GetPage(name: '/', page: () => LoginScreen(),transition: Transition.cupertino),
        GetPage(name: '/home', page: () => HomeWithSidebarTest(),transition: Transition.cupertino),
        GetPage(name: '/article', page: () => ArticlePage(),transition: Transition.cupertino),
        GetPage(name: '/articleDetails', page: () => ArticleDetailsPage(),transition: Transition.cupertino),
        GetPage(name: '/lateCheckIn', page: () => LateCheckIn(),transition: Transition.cupertino),
        //GetPage(name: '/sideBar', page: () => SideBar(),transition: Transition.cupertino),
      ],
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: MyBehavior(),
          child: child,
        );
      },
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // Add global cupertino localizations.
      ],
      locale: Locale('en', 'US'),
      // Current locale
      supportedLocales: [
        const Locale('en', 'US'), // English
        const Locale('th', 'TH'), // Thai
      ],
    );


  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
