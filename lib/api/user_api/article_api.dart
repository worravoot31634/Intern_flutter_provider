import 'package:dio/dio.dart' hide Headers;

import 'package:provider_flutter_application/api/api_client.dart';
import 'package:provider_flutter_application/model/article.dart';

class ArticleApi {
  Dio dio;
  ApiClient apiClient;

  ArticleApi() {
    dio = new Dio();
    apiClient = new ApiClient(dio);
  }

  Future<List<Article>> getAllArticle() async {
    List<Article> response;

    try {
      response = await apiClient.getAllArticle();
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
    return response;
  }
}
