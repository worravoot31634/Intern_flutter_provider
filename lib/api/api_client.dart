import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:provider_flutter_application/model/article.dart';
import 'package:provider_flutter_application/model/holiday.dart';
import 'package:provider_flutter_application/model/ticket.dart';
import 'package:provider_flutter_application/model/user.dart';
import 'package:provider_flutter_application/model/work_hours.dart';
import 'package:retrofit/retrofit.dart';


import 'package:provider_flutter_application/global.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "${Global.BASE_API_URL}")
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  /* User */
  @GET("/ms-user-list")
  Future<List<User>> getAllUser();

  @POST("/ms-user-login")
  @FormUrlEncoded()
  Future<User> getUserByLogin(@Body() User user);

  /* End of User */

  /* Article */
  @GET("/ms-article-list")
  Future<List<Article>> getAllArticle();

  /* End of Article */

  /* WorkHours */
  @POST("/ms-workhours-by-id")
  @FormUrlEncoded()
  Future<List<WorkHours>> getWorkHoursById(@Body() User user);

  @POST("/ms-workhours-checkIn-today")
  @FormUrlEncoded()
  Future<List<WorkHours>> getTodayCheckInById(@Body() User user);

  @POST("/ms-workhours-checkOut-today")
  @FormUrlEncoded()
  Future<List<WorkHours>> getTodayCheckOutById(@Body() User user);

  @POST("/ms-checkIn")
  @FormUrlEncoded()
  Future<String> checkInAndOut(@Body() WorkHours workHours);

  @POST("/ms-lateCheckIn")
  @FormUrlEncoded()
  Future<String> lateCheckInAndOut(@Body() WorkHours workHours);

  @POST("/ms-workhours-last-checkIn")
  @FormUrlEncoded()
  Future<WorkHours> getLastCheckInById(@Body() User user);

  /* End of WorkHours */

/* Holiday */
  @POST("/ms-holiday-list")
  Future<List<Holiday>> getAllHoliday();

/* End of Holiday */

/* Ticket */
  @POST("/ms-ticket-list")
  Future<List<Ticket>> getAllTicket();

  @POST("/ms-add-ticket")
  @FormUrlEncoded()
  Future<String> addTicket(@Part()  Ticket ticket, @Part() File fileUpload, @Part() String fileName);

  @POST("/ms-add-ticket")
  @FormUrlEncoded()
  Future<String> addTicketWithoutFile(@Part()  Ticket ticket);

/* End of Ticket */

}
