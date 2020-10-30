// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_client.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiClient implements ApiClient {
  _ApiClient(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.0.110:8080';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<List<User>> getAllUser() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/ms-user-list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => User.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<User> getUserByLogin(user) async {
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>('/ms-user-login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = User.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Article>> getAllArticle() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/ms-article-list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Article.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<WorkHours>> getWorkHoursById(user) async {
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>('/ms-workhours-by-id',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => WorkHours.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<WorkHours>> getTodayCheckInById(user) async {
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/ms-workhours-checkIn-today',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => WorkHours.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<WorkHours>> getTodayCheckOutById(user) async {
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<List<dynamic>>(
        '/ms-workhours-checkOut-today',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => WorkHours.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<String> checkInAndOut(workHours) async {
    ArgumentError.checkNotNull(workHours, 'workHours');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(workHours?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<String>('/ms-checkIn',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<String> lateCheckInAndOut(workHours) async {
    ArgumentError.checkNotNull(workHours, 'workHours');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(workHours?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<String>('/ms-lateCheckIn',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<WorkHours> getLastCheckInById(user) async {
    ArgumentError.checkNotNull(user, 'user');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(user?.toJson() ?? <String, dynamic>{});
    _data.removeWhere((k, v) => v == null);
    final _result = await _dio.request<Map<String, dynamic>>(
        '/ms-workhours-last-checkIn',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = WorkHours.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<Holiday>> getAllHoliday() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/ms-holiday-list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Holiday.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Ticket>> getAllTicket() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('/ms-ticket-list',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Ticket.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<String> addTicket(ticket, fileUpload, fileName) async {
    ArgumentError.checkNotNull(ticket, 'ticket');
    ArgumentError.checkNotNull(fileUpload, 'fileUpload');
    ArgumentError.checkNotNull(fileName, 'fileName');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields
        .add(MapEntry('ticket', jsonEncode(ticket ?? <String, dynamic>{})));
    _data.files.add(MapEntry(
        'fileUpload',
        MultipartFile.fromFileSync(fileUpload.path,
            filename: fileUpload.path.split(Platform.pathSeparator).last)));
    if (fileName != null) {
      _data.fields.add(MapEntry('fileName', fileName));
    }
    final _result = await _dio.request<String>('/ms-add-ticket',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }

  @override
  Future<String> addTicketWithoutFile(ticket) async {
    ArgumentError.checkNotNull(ticket, 'ticket');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = FormData();
    _data.fields
        .add(MapEntry('ticket', jsonEncode(ticket ?? <String, dynamic>{})));
    final _result = await _dio.request<String>('/ms-add-ticket',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            contentType: 'application/x-www-form-urlencoded',
            baseUrl: baseUrl),
        data: _data);
    final value = _result.data;
    return value;
  }
}
