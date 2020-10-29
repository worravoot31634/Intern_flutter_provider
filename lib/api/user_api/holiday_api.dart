import 'package:dio/dio.dart';
import 'package:provider_flutter_application/api/api_client.dart';
import 'package:provider_flutter_application/model/holiday.dart';

class HolidayApi {
  Dio dio;
  ApiClient apiClient;

  HolidayApi(){
    dio = new Dio();
    apiClient = new ApiClient(dio);
  }

  Future<List<Holiday>> getAllHoliday() async {
    List<Holiday> response;
    try {
      response = await apiClient.getAllHoliday();
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
    return response;
  }


}