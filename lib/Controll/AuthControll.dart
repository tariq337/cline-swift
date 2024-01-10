import 'dart:developer';

import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/server/DioSever.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthControll extends GetxController with DioServer {
  String errorMsg = '';
  bool isloading = false;
  Dio dio = Dio();
  GetStorage localDB = GetStorage();

  Future<void> register(
      {required String userName,
      required String email,
      required String password}) async {
    runLoading();
    await post(
        dio: dio,
        url: unitUrl.register,
        key: "register",
        data: {"name": userName, "email": email, "password": password});
  }

  Future<void> login({required String email, required String password}) async {
    runLoading();
    await post(
        dio: dio,
        url: unitUrl.login,
        key: "login",
        data: {"email": email, "password": password});
  }

//add apiKey
  Future<void> addApiKey() async {
    dio.options.headers['apiKey'] = await localDB.read("apiKey");
  }

//reloade
  runLoading() {
    isloading = true;
    errorMsg = "";
    update();
  }

  stopLoading() {
    isloading = false;
    update();
  }

//output and error from Dio
  @override
  void error(String error) {
    // TODO: implement error
    super.error(error);

    errorMsg = error;

    stopLoading();
  }

  @override
  void output(String key, data) async {
    // TODO: implement output
    super.output(key, data);

    switch (key) {
      case "login":
        log(data["apiKey"].toString());
        await localDB.write("apiKey", data["apiKey"]);
        break;
    }

    stopLoading();
  }
}
