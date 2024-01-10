import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/models/StaticsModel.dart';
import 'package:client_swift/server/DioSever.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class StaticsControll extends GetxController with DioServer {
  RxString errorMsg = "".obs;
  RxBool isloading = false.obs;
  Rx<StaticsModel> staticsModel = StaticsModel().obs;
  Dio dio = Dio();
  GetStorage localDB = GetStorage();

  Future<void> getStatics() async {
    runLoading();
    await addApiKey();

    await get(dio: dio, url: unitUrl.statics, key: "getStatics");
  }

  @override
  void onInit() {
    super.onInit();
    getStatics();
  }

//add apiKey
  Future<void> addApiKey() async {
    dio.options.headers['apiKey'] = await localDB.read("apiKey");
  }

//reloade
  runLoading() {
    isloading(true);
    errorMsg("");
    update();
  }

  stopLoading() {
    isloading(false);
    update();
  }

//output and error from Dio
  @override
  void error(String error) {
    // TODO: implement error
    super.error(error);

    errorMsg(error);

    stopLoading();
  }

  @override
  void output(String key, data) async {
    // TODO: implement output
    super.output(key, data);

    switch (key) {
      case "getStatics":
        staticsModel(StaticsModel.fromJson(data));
        break;
    }

    stopLoading();
  }
}
