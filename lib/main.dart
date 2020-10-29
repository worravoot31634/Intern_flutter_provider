import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/provider/article_provider.dart';
import 'package:provider_flutter_application/provider/home_provider.dart';
import 'package:provider_flutter_application/provider/late_checkin_provider.dart';
import 'package:provider_flutter_application/provider/login_provider.dart';
import 'package:provider_flutter_application/provider/side_bar/header_app_provider.dart';
import 'package:provider_flutter_application/provider/side_bar/side_bar_provider.dart';
import 'package:provider_flutter_application/screens/screen/login_screen.dart';
import 'package:provider_flutter_application/screens/screenWithSidebar/add_ticket_with_sidebar.dart';
import 'package:provider_flutter_application/screens/screenWithSidebar/article_details_with_sidebar.dart';
import 'package:provider_flutter_application/screens/screenWithSidebar/article_with_sidebar.dart';
import 'package:provider_flutter_application/screens/screenWithSidebar/home_with_sidebar.dart';
import 'package:provider_flutter_application/screens/screenWithSidebar/late_checkIn_with_sidebar.dart';
import 'package:provider_flutter_application/screens/screenWithSidebar/ticket_with_sidebar.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => HeaderAppProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => LateCheckInProvider()),
        ChangeNotifierProvider(create: (_) => SideBarProvider()),
      ],child: MyApp()),

  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));

    return OverlaySupport(
      child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: LoginScreen(),
          getPages: [
            GetPage(name: '/login', page: () => LoginScreen(),transition: Transition.cupertino),
            GetPage(name: '/home', page: () => HomeWithSidebar(),transition: Transition.cupertino),
            GetPage(name: '/article', page: () => ArticleWithSidebar(),transition: Transition.cupertino),
            GetPage(name: '/articleDetails', page: () => ArticleDetailsWithSidebar(),transition: Transition.cupertino),
            GetPage(name: '/lateCheckIn', page: () => LateCheckInWithSidebar(),transition: Transition.cupertino),
            GetPage(name: '/ticket', page: () => TicketWithSidebar(),transition: Transition.cupertino),
            GetPage(name: '/addTicket', page: () => AddTicketWithSidebar(),transition: Transition.cupertino),
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
          supportedLocales: [
            const Locale('en', 'US'), // English
            const Locale('th', 'TH'), // Thai
          ],
        ),

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
