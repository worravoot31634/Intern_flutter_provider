import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:provider_flutter_application/api/user_api/article_api.dart';
import 'package:provider_flutter_application/model/article.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> _article = [];

  List<Article> get article => _article;

  String _test = "test";

  String get test => _test;

  void fetchArticle() async {
    ArticleApi articleApi = new ArticleApi();
    _article = await articleApi.getAllArticle();
    log('load article');
    notifyListeners();
  }
}
