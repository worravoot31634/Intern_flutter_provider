import 'dart:io';

import 'package:dio/dio.dart';
import 'package:provider_flutter_application/api/api_client.dart';
import 'package:provider_flutter_application/model/ticket.dart';



class TicketApi {
  Dio dio;
  ApiClient apiClient;

  TicketApi() {
    dio = new Dio();
    apiClient = new ApiClient(dio);
  }

  Future<List<Ticket>> getAllTicket() async {
    List<Ticket> response;

    try {
      response = await apiClient.getAllTicket();
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
    return response;
  }

  Future<String> addTicket(Ticket ticket, File fileUpload, String fileName) async {
    String response;

    try {
      response = await apiClient.addTicket(ticket, fileUpload, fileName);
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
    return response;
  }

  Future<String> addTicketWithoutFile(Ticket ticket) async {
    String response;

    try {
      response = await apiClient.addTicketWithoutFile(ticket);
      //print(response);
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
    }
    return response;
  }

}