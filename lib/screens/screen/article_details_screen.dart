

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider_flutter_application/global.dart';
import 'package:provider_flutter_application/model/article.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';
import 'package:provider_flutter_application/screens/widgets/header_app.dart';


class ArticleDetailsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Get.arguments != null ? _ArticleDetailsScreen(article: Get.arguments) : Text('ERROR send Data!'),
    );
  }
}

class _ArticleDetailsScreen extends StatelessWidget {

  _ArticleDetailsScreen({this.article});

  final Article article;

  @override
  Widget build(BuildContext context) {
    String articleId;
    String topic;
    String writer;
    String timeCreate;
    String imgAssetPath;
    Article articleList;
    //Initial Value
    articleId = article.articleId.toString();
    topic = article.topic;
    writer = article.userCreate;
    imgAssetPath = Global.BASE_API_URL + article.path;
    timeCreate = article.timeCreate;

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
                  headerApp(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: AutoSizeText(
                        topic,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 21,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'prompt',
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
                                fontFamily: 'prompt',
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
                                fontFamily: 'prompt',
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
                        dateStrToDateTime(timeCreate),
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'prompt',
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
                              imgAssetPath,
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
