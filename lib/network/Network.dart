import 'dart:io';

import 'package:creator/pref/SharedPref.dart';
import 'package:dio/dio.dart';

import 'package:dio/dio.dart';

class NetworkClass {
  Dio? _dio;

  NetworkClass() {
    BaseOptions options = BaseOptions(
      baseUrl: "http://51.112.6.160:3000/",
    );

    _dio = Dio(options);
    _dio?.interceptors
        .add(LogInterceptor(responseBody: true, requestBody: true));

    _dio?.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioError e, handler) {
        return handler.next(e);
      },
    ));
  }

  Future<Response> getRequest(String endpoint,
      {Map<String, dynamic>? headers}) async {
    try {
      Map<String, dynamic> defaultHeaders = {
        'access_token': await SharedPref.getAccessToken(),
        'Content-Type': 'application/json',
      };
      Response response = await _dio!.get(
        endpoint,
        options: Options(headers: headers ?? defaultHeaders),
      );
      print('Response ===> $response');
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> postRequest(String endpoint, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      Map<String, dynamic> defaultHeaders = {
        'access_token': await SharedPref.getAccessToken(),
        'Content-Type': 'application/json',
      };
      Response response = await _dio!.post(
        endpoint,
        data: data,
        options: Options(headers: headers ?? defaultHeaders),
      );
      print('Response ===> $response');
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> uploadfile(String endpoint, String value, File file) async {
    try {
      String fileName = file.path.split('/').last;
      FormData data = FormData.fromMap({
        value: await MultipartFile.fromFile(
          file.path,
          filename: fileName,
        ),
      });
      Response response = await _dio!.post(
        endpoint,
        data: data,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}



