import 'dart:developer';

import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/models/OrdersModel.dart' as porder;
import 'package:client_swift/models/StaticOrders.dart';
import 'package:client_swift/models/VehiclesModel.dart';
import 'package:client_swift/server/DioSever.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../models/FirstOrderModel.dart';

class OrderControll extends GetxController with DioServer {
  bool isView = false;

  RxBool isViewobx = false.obs;
  ///////////////////////
  Rx<porder.OrdersModel> ordersModel = porder.OrdersModel().obs;
  Rx<porder.Details> order = porder.Details().obs;

  Rx<VehiclesModel> vehiclesModel = VehiclesModel().obs;
  RxString vehiclesId = "".obs;
  RxString orderId = "".obs;
  RxString deliveryId = "".obs;
  RxString agintsId = "".obs;

  RxString errorMsg = "".obs;
  RxBool isloading = false.obs;
  Dio dio = Dio();
  GetStorage localDB = GetStorage();

  Future<void> getOrders() async {
    runLoading();
    await addApiKey();
    await get(dio: dio, url: unitUrl.order, key: "getOrders");
  }

  setVehiclesId(String vId, String oId) {
    vehiclesId(vId);
    orderId(oId);
  }

  Future<void> postOrderFirst(
      {required List<Map<String, dynamic>> firstOrderModel}) async {
    runLoading();
    await addApiKey();

    /*   vehiclesModel(VehiclesModel.fromJson({
      "id": "dbeabaaf-096f-4d65-b134-3f255397f427",
      "vehicles": [
        {
          "area": "300x49x10",
          "id": "c19983be-c0b2-494d-935d-31ef8185fc11",
          "imageUrl": "xid2439160248522506817956353658801",
          "name": "scooter",
          "price": 523673.85498907254,
          "speed": 300,
          "weight": 300
        },
        {
          "area": "400x49x10",
          "id": "5d64a5dc-86fc-45d0-a49b-5b88982b562b",
          "imageUrl": "xid6785056655639590504490680876462",
          "name": "car",
          "price": 872789.7583151209,
          "speed": 400,
          "weight": 400
        },
        {
          "area": "500x49x10",
          "id": "0655283f-0894-41d4-a709-5b02c8a820bc",
          "imageUrl": "xid3235408339678278635915691705103",
          "name": "truck",
          "price": 1221905.6616411693,
          "speed": 400,
          "weight": 1000
        },
        {
          "area": "300x49x10",
          "id": "e8610fa1-b110-415f-b243-d6c0da7582ad",
          "imageUrl": "xid46029041584752906547558193489511",
          "name": "Car2",
          "price": 523673.85498907254,
          "speed": 300,
          "weight": 300
        }
      ]
    }));
   */

    await post(
        dio: dio,
        url: unitUrl.firstStap,
        key: "postOrderFirst",
        data: {"drops": firstOrderModel});
  }

  Future<void> orderDelet(String id) async {
    runLoading();
    await addApiKey();
    await delete(dio: dio, url: unitUrl.orderDelet(id), key: "delet");
  }

  Future<void> postOrderScond() async {
    runLoading();
    await addApiKey();
    await post(dio: dio, url: unitUrl.secondStep, key: "postOrderScond", data: {
      "agentId": agintsId.value,
      "deliveryId": deliveryId.value,
      "orderId": orderId.value,
      "vehicleId": vehiclesId.value
    });
  }

  Future<void> refreshOrders({required String id}) async {
    runLoading();
    await addApiKey();
    await get(
      dio: dio,
      url: unitUrl.refreshStep(id),
      key: "postOrderFirst",
    );
  }

  List<StaticOrderModel> staticOrder() {
    List<StaticOrderModel> staticsOrder = [];
    int s1 = 0;
    int s2 = 0;
    int s3 = 0;
    int s4 = 0;
    int s5 = 0;
    int s = 0;
    for (porder.Details i in (ordersModel.value.details ?? [])) {
      for (int index = 1; index < (i.points ?? []).length; index++) {
        if (i.points![index].state == null) {
          s++;
        } else {
          log(i.points![index].state!.id.toString());
          switch ((i.points![index].state!.id ?? 0) == 3
              ? i.points![0].state!.id ?? 0
              : i.points![index].state!.id ?? 0) {
            case 0:
              s++;
              break;
            case 1:
              s1++;
              break;
            case 2:
              s2++;
              break;
            case 3:
              s3++;
              break;
            case 4:
              s4++;
              break;
            case 5:
              s5++;
              break;
            default:
              break;
          }
        }
      }
    }

    staticsOrder.addAll([
      StaticOrderModel(
          title: language[modeControll.LanguageValue]["staticOrders"][1],
          percentage: s1,
          color: classColors.STATICS(modeControll.ThemeModeValue)[0],
          numOfOrders: s + s1 + s2 + s3 + s4 + s5),
      StaticOrderModel(
          title: language[modeControll.LanguageValue]["staticOrders"][3],
          percentage: s3,
          color: classColors.STATICS(modeControll.ThemeModeValue)[1],
          numOfOrders: s + s1 + s2 + s3 + s4 + s5),
      StaticOrderModel(
          title: language[modeControll.LanguageValue]["staticOrders"][4],
          percentage: s4,
          color: classColors.STATICS(modeControll.ThemeModeValue)[2],
          numOfOrders: s + s1 + s2 + s3 + s4 + s5),
      StaticOrderModel(
          title: language[modeControll.LanguageValue]["staticOrders"][5],
          percentage: s5,
          color: classColors.STATICS(modeControll.ThemeModeValue)[3],
          numOfOrders: s + s1 + s2 + s3 + s4 + s5),
    ]);
    return staticsOrder;
  }

  @override
  void onInit() {
    super.onInit();
    getOrders();
  }

/////////////////////
  clear() {
    isView = false;
    isViewobx(false);

    update();
  }

  setdata(porder.Details details) {
    order.value = details;
    isView = true;
    isViewobx(true);
    update();
  }

  addOrder() {
    pageOrderController.animateToPage(1,
        duration: const Duration(milliseconds: 300), curve: Curves.ease);
  }

//add apiKey
  Future<void> addApiKey() async {
    dio.options.headers['apiKey'] = await localDB.read("apiKey");
  }

//reloade
  runLoading() {
    isloading(true);
    errorMsg("");
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
    log("$data");

    switch (key) {
      case "delet":
        await getOrders();
        break;
      case "getOrders":
        ordersModel(porder.OrdersModel.fromJson(data));
        break;

      case "postOrderFirst":
        vehiclesModel(VehiclesModel.fromJson(data));

        break;
    }

    stopLoading();
  }
}
