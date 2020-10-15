import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/article_screen.dart';
import 'package:provider_flutter_application/screens/side_bar/sidebar_test.dart';
import '../home_screen.dart';

class ArticleWithSidebarTest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: articleWithSidebarTest(),
    );
  }
}

class articleWithSidebarTest extends StatefulWidget {
  @override
  _articleWithSidebarStateTest createState() => _articleWithSidebarStateTest();
}

class _articleWithSidebarStateTest extends State<articleWithSidebarTest>{

  @override
  Widget build(BuildContext context) {
    return SideBarTest(screen: ArticlePage());
  }
}
