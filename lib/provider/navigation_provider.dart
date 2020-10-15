import 'package:flutter/cupertino.dart';
import 'package:provider_flutter_application/screens/article_screen.dart';
import 'package:provider_flutter_application/screens/home_screen.dart';
import 'package:provider_flutter_application/screens/login_screen.dart';

class NavigationProvider extends ChangeNotifier {
  String currentNavigation = "login";

  Widget get getNavigation {

    switch (currentNavigation) {
      case 'login' : return LoginScreen();
      break;
      case 'home' : return HomeScreen();
      break;
      case 'article' : return ArticlePage();
      break;
      default: return null;
      break;
    }

  }

  void updateNavigation(String navigation) {
    currentNavigation = navigation;
    notifyListeners();
  }


}