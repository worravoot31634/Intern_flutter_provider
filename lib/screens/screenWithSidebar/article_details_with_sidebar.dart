import 'package:flutter/material.dart';
import 'package:provider_flutter_application/screens/screen/article_details_screen.dart';
import 'package:provider_flutter_application/screens/screen/article_screen.dart';
import 'package:provider_flutter_application/screens/side_bar/side_bar.dart';

class ArticleDetailsWithSidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: articleDetailsWithSidebar(),
    );
  }
}

class articleDetailsWithSidebar extends StatefulWidget {
  @override
  _articleDetailsWithSidebarState createState() => _articleDetailsWithSidebarState();
}

class _articleDetailsWithSidebarState extends State<articleDetailsWithSidebar>{

  @override
  Widget build(BuildContext context) {
    return SideBar(screen: ArticleDetailsScreen());
  }
}
