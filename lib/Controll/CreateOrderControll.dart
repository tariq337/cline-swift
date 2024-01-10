import 'dart:developer';

import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/models/AgentsModel.dart';
import 'package:client_swift/models/DeliveryModel.dart';
import 'package:client_swift/server/DioSever.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';

class CreateOrderControll extends GetxController with DioServer {
  RxString errorMsgAgints = "".obs;
  RxString errorMsgDelivery = "".obs;
  RxString errorMsg = "".obs;

  RxBool isloadingAgints = true.obs;
  RxBool isloading = false.obs;
  RxBool isloadingDelivery = true.obs;
  RxBool isView = false.obs;
  RxInt index = 0.obs;

  Rx<DeliveryModel> deliveryModel = DeliveryModel().obs;
  Rx<AgentModel> agentModel = AgentModel().obs;

  Dio dio = Dio();
  GetStorage localDB = GetStorage();

  view(int i) {
    index(i);
    isView(true);
  }

  clear() {
    isView(false);
  }

  Future<void> getAgints({required String vehiclesId}) async {
    runLoadingAgints();
    await addApiKey();
    await getIn(
        dio: dio,
        url: unitUrl.agents(vehiclesId),
        output: (dynamic data) {
          log("________________$data");
          agentModel(AgentModel.fromJson(data));
        },
        error: (String error) {
          errorMsgAgints(error);
        });
    stopLoadingAgints();
  }

  Future<LatLng> getLocation() async {
    String location = await localDB.read("location");
    LatLng locationdata = LatLng(double.parse(location.split(",")[0]),
        double.parse(location.split(",")[1]));
    log("${locationdata.latitude} : ${locationdata.longitude}");
    return locationdata;
  }

  Future<void> getDelivery({required String vehiclesId}) async {
    runLoadingDelivery();
    log("getDelivery");
    await addApiKey();
    await getIn(
        dio: dio,
        url: unitUrl.deliveries(vehiclesId),
        output: (dynamic data) {
          log(data.toString());
          deliveryModel(DeliveryModel.fromJson(data));
        },
        error: (String error) {
          errorMsgAgints(error);
        });
    stopLoadingDelivery();
  }

  Future<void> postOrderScond(
      {required String agintsId,
      required String deliveryId,
      required String orderId,
      required String vehiclesId}) async {
    runLoading();
    await addApiKey();
    await post(dio: dio, url: unitUrl.secondStep, key: "postOrderScond", data: {
      "agentId": agintsId,
      "deliveryId": deliveryId,
      "orderId": orderId,
      "vehicleId": vehiclesId
    });
  }

//add apiKey
  Future<void> addApiKey() async {
    dio.options.headers['apiKey'] = await localDB.read("apiKey");
  }

//reloade
  runLoadingAgints() {
    isloadingAgints(true);
    errorMsgAgints("");
  }

  runLoadingDelivery() {
    isloadingDelivery(true);
    errorMsgDelivery("");
  }

  runLoading() {
    isloading(true);
    errorMsg("");
  }

  stopLoadingAgints() {
    isloadingAgints(false);
    errorMsg("");
  }

  stopLoadingDelivery() {
    isloadingDelivery(false);
  }

  stopLoading() {
    isloading(false);
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
    log(data.toString());
    switch (key) {
      case "getOrders":
        break;
    }

    stopLoading();
  }
}
