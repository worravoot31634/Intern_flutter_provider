import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/provider/article_provider.dart';
import 'package:provider_flutter_application/provider/home_provider.dart';
import 'package:provider_flutter_application/provider/login_provider.dart';
import 'package:provider_flutter_application/screens/article_details_screen.dart';
import 'package:provider_flutter_application/screens/article_screen.dart';
import 'package:provider_flutter_application/screens/home_screen.dart';
import 'package:provider_flutter_application/screens/late_checkIn_screen.dart';
import 'package:provider_flutter_application/screens/login_screen.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
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
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/article', page: () => ArticlePage()),
        GetPage(name: '/articleDetails', page: () => ArticleDetailsPage()),
        GetPage(name: '/lateCheckIn', page: () => LateCheckIn()),
      ],
    );
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
