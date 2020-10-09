import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider_flutter_application/api/user_api/article_api.dart';
import 'package:provider_flutter_application/model/article.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _articleListView;
  int _countItemListArticle;
  int _lenArticleList;
  bool _articleScreenLoading = true;

  //refresh
  RefreshController _refreshController;

  List<Article> get articleListView => _articleListView;
  int get countItemListArticle => _countItemListArticle;
  int get lenArticleList => _lenArticleList;
  bool get articleScreenLoading => _articleScreenLoading;
  RefreshController get refreshController => _refreshController;

  ArticleProvider (){
    initState();
  }

  void initState(){
    _refreshController = RefreshController(initialRefresh: false);
    _countItemListArticle = 10;
    getAllArticle();

  }

  void getAllArticle() async {

    _articleScreenLoading = true;
    notifyListeners();

    ArticleApi articleApi = new ArticleApi();
    _articleListView = await articleApi.getAllArticle();
    _lenArticleList =_articleListView.length;
    _articleScreenLoading = false;
    log('load article finished' , name: 'articleProvider');
    notifyListeners();
  }

  void onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (_countItemListArticle < _lenArticleList) {
      // get 2 list when refresh
      if (_countItemListArticle + 2 <= _lenArticleList) {
        _countItemListArticle += 2;
      } else if (_countItemListArticle + 1 <= _lenArticleList) {
        _countItemListArticle += 1;
      }
      log("countItemArticle: " + _countItemListArticle.toString());
      log("len: " + _lenArticleList.toString());

      _articleListView.add((_articleListView[_countItemListArticle]));
      _refreshController.loadComplete();
    } else {
      log("no data");
      _refreshController.loadNoData();
    }
    notifyListeners();

  }

  void onRefresh() async {
    // monitor network fetch
    // await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _countItemListArticle = 10;
    log("refresh! count = " + countItemListArticle.toString());

    getAllArticle();

    refreshController.refreshCompleted();
    notifyListeners();
  }


}
