import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:provider_flutter_application/animation/LoadingCubeGridAnimation.dart';
import 'package:provider_flutter_application/model/article.dart';
import 'package:provider_flutter_application/global.dart';
import 'package:provider_flutter_application/provider/article_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider_flutter_application/screens/widgets/header_app.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _ArticleScreen(),
    );
  }
}

class _ArticleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    log('Build at ' + DateTime.now().toString(),name: '[Article Screen]');
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              color: Colors.grey[100],
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
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/document.png",
                        height: 22,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Article",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w800,
                            fontFamily: 'avenir'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Consumer<ArticleProvider>(
              builder: (BuildContext context, states, Widget child) => Container(
                padding: EdgeInsets.only(
                  top: 130.0,
                  left: 30.0,
                  right: 30.0,
                ),
                child: states.articleScreenLoading
                    ? LoadingCubeGrid()
                    : SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  header: ClassicHeader(),
                  footer: CustomFooter(
                    builder: (BuildContext context, LoadStatus mode) {
                      Widget body;
                      if (mode == LoadStatus.idle) {
                        body = Text("pull up load");
                      } else if (mode == LoadStatus.loading) {
                        body = CupertinoActivityIndicator();
                      } else if (mode == LoadStatus.failed) {
                        body = Text("Load Failed!Click retry!");
                      } else if (mode == LoadStatus.canLoading) {
                        body = Text("more article");
                      } else {
                        body = Text("No more Data");
                      }
                      return Container(
                        height: 55.0,
                        child: Center(child: body),
                      );
                    },
                  ),
                  controller: states.refreshController,
                  onRefresh: states.onRefresh,
                  onLoading: states.onLoading,
                  child: Container(
                    child: ListView.builder(
                      itemCount: states.articleListView.length > 10
                          ? states.countItemListArticle
                          : states.articleListView.length,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Get.toNamed('articleDetails',arguments: states.articleListView[index]);
                          },
                          child: ArticleTile(
                            //Send List to Tile
                            articleList: states.articleListView[index],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleTile extends StatelessWidget {
  String articleId;
  String topic;
  String timeCreate;
  String imgAssetPath;
  Article articleList;

  /// later can be changed with imgUrl
  ArticleTile({this.articleList});

  @override
  Widget build(BuildContext context) {
    //Initial Value
    articleId = articleList.articleId.toString();
    topic = articleList.topic;
    imgAssetPath = Global.BASE_API_URL + articleList.path;
    timeCreate = articleList.timeCreate;

    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Color(0xff29404E),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 5.0,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AutoSizeText(
                    '$topic',
                    maxLines: 2,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'prompt',
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/clock.png",
                        height: 12,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      AutoSizeText(
                        '${dateStrToDateTime(timeCreate)}',
                        maxLines: 1,
                        style: TextStyle(color: Colors.white, fontSize: 12,fontFamily: 'prompt',),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(8),
              bottomRight: Radius.circular(8),
            ),
            child: new Image.network(
              imgAssetPath,
              height: 100,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  String dateStrToDateTime(String strDateTime) {
    DateTime oldFormat =
        new DateFormat("MMM dd, yyyy hh:mm:ss a").parse(strDateTime);
    String newFormat = DateFormat("d MMM yyyy HH:mm").format(oldFormat);

    return newFormat;
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
