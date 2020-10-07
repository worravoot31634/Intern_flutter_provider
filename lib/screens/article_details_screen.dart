import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_flutter_application/model/article.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../global.dart';

class ArticleDetailsPage extends StatelessWidget {
  Article article;

  ArticleDetailsPage({this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: articleDetailsPage(article: article),
    );
  }
}

class articleDetailsPage extends StatefulWidget {
  Article article;

  articleDetailsPage({this.article});

  @override
  _articleDetailsPageState createState() =>
      _articleDetailsPageState(article: article);
}

class _articleDetailsPageState extends State<articleDetailsPage> {
  Article article;
  String articleId;
  String topic;
  String writer;
  String time_create;
  String img_asset_path;
  Article articleList;

  _articleDetailsPageState({this.article});

  @override
  Widget build(BuildContext context) {
    //Initial Value
    articleId = article.articleId.toString();
    topic = article.topic;
    writer = article.userCreate;
    img_asset_path = API.BASE_API_URL + article.path;
    time_create = article.timeCreate;

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/logo.png",
                        width: 50,
                        height: 50,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            "Cube SoftTech",
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'ubuntu',
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Image.asset(
                        "assets/images/notification.png",
                        height: 22,
                      ),
                      SizedBox(width: 16),
                      Image.asset(
                        "assets/images/menu.png",
                        height: 22,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        topic,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'avenir',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Writer: ",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'avenir',
                              ),
                            ),
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              writer,
                              style: TextStyle(
                                color: Colors.red[400],
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'avenir',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        dateStrToDateTime(time_create),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'avenir',
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            child: Image.network(
                              img_asset_path,
                              fit: BoxFit.cover,
                              alignment: Alignment.center,
                            ),
                          ),
                          Container(
                            child: Html(
                              data: """${article.detail}""",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String dateStrToDateTime(String strDateTime) {
    //articleListView.data[index].timeCreate
    DateTime oldFormat =
        new DateFormat("MMM dd, yyyy hh:mm:ss a").parse(strDateTime);
    // log("dateFormat: " + oldFormat.toString());
    String newFormat = DateFormat("d MMM yyyy HH:mm").format(oldFormat);
    //log("dateFormat2: " + newFormat.toString());
    return newFormat;
  }
}
