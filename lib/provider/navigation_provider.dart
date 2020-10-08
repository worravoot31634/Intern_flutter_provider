import 'package:flutter/cupertino.dart';
import 'package:provider_flutter_application/screens/article_screen.dart';
import 'package:provider_flutter_application/screens/home_screen.dart';
import 'package:provider_flutter_application/screens/login_screen.dart';

class NavigationProvider extends ChangeNotifier {
  String currentNavigation = "Login";

  Widget get getNavigation {

    if (currentNavigation == "Home") {
      return HomeScreen();
    } else if (currentNavigation == "Article") {
      return ArticlePage();
    } else {
      return LoginScreen();
    }
  }

  void updateNavigation(String navigation) {
    currentNavigation = navigation;
    notifyListeners();
  }


}