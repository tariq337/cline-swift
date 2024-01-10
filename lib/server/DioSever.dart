// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:dio/dio.dart';

mixin DioServer {
  Future<void> get({
    required Dio dio,
    required String url,
    Object? data,
    required String key,
  }) async {
    try {
      final response = await dio.get(url, data: data);
      if (response.statusCode == 200) {
        output(key, response.data);
      } else {
        error(response.data["ERROR"]);
      }
    } on DioError catch (e) {
      error(dioException(e));
    } catch (e) {
      error(catchException(e));
    }
  }

  Future<void> getIn({
    required Function(dynamic) output,
    required Function(String) error,
    required Dio dio,
    required String url,
    Object? data,
  }) async {
    try {
      final response = await dio.get(url, data: data);
      if (response.statusCode == 200) {
        output(response.data);
      } else {
        error(response.data["ERROR"]);
      }
    } on DioError catch (e) {
      error(dioException(e));
    } catch (e) {
      error(catchException(e));
    }
  }

  Future<void> post(
      {required Dio dio,
      required String url,
      Object? data,
      required String key}) async {
    try {
      final response = await dio.post(url, data: data);
      if (response.statusCode == 200) {
        output(key, response.data);
      } else {
        error(response.data["ERROR"]);
      }
    } on DioError catch (e) {
      error(dioException(e));
    } catch (e) {
      error(catchException(e));
    }
  }

  Future<void> put(
      {required Dio dio,
      required String url,
      Object? data,
      required String key}) async {
    try {
      final response = await dio.put(url, data: data);
      if (response.statusCode == 200) {
        output(key, response.data);
      } else {
        error(response.data["ERROR"]);
      }
    } on DioError catch (e) {
      error(dioException(e));
    } catch (e) {
      error(catchException(e));
    }
  }

  Future<void> delete(
      {required Dio dio,
      required String url,
      Object? data,
      required String key}) async {
    try {
      final response = await dio.delete(url, data: data);
      if (response.statusCode == 200) {
        output(key, response.data);
      } else {
        error(response.data["ERROR"]);
      }
    } on DioError catch (e) {
      error(dioException(e));
    } catch (e) {
      error(catchException(e));
    }
  }

// output and error method

  void output(String key, dynamic data) {}
  void error(String error) {}
//Exception
  String dioException(DioException e) {
    log(e.toString());

    if (e.response != null) {
      if (e.response!.statusCode == 401) {
        return language[modeControll.LanguageValue]["dio"][0];
      } else if (e.response!.statusCode == 400) {
        return language[modeControll.LanguageValue]["dio"][1];
      }
    }
    return language[modeControll.LanguageValue]["dio"][2];
  }

  String catchException(e) {
    log(e.toString());
    return language[modeControll.LanguageValue]["dio"][2];
  }
}
