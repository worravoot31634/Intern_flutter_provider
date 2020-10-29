import 'dart:io';

import 'package:dio/dio.dart';

import '../api_client.dart';

class FileUploadApi {
  Dio dio;
  ApiClient apiClient;

  FileUploadApi() {
    dio = new Dio();
    apiClient = new ApiClient(dio);
  }

  Future<String> addImage(File fileUpload,String fileName)async {
    String response;

    try {
      response = await apiClient.addFileUpload(fileUpload, fileName);
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
    return response;
  }


}