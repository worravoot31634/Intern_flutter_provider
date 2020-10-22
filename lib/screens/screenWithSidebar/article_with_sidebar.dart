import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/screen/article_screen.dart';
import 'package:provider_flutter_application/screens/side_bar/side_bar.dart';

class ArticleWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: articleWithSidebar(),
    );
  }
}

class articleWithSidebar extends StatefulWidget {
  @override
  _articleWithSidebarState createState() => _articleWithSidebarState();
}

class _articleWithSidebarState extends State<articleWithSidebar>{

  @override
  Widget build(BuildContext context) {
    return SideBar(screen: ArticleScreen());
  }
}
