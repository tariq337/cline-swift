import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/server/DioSever.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';

class FormControll extends GetxController with DioServer {
  RxInt numberForm = 0.obs;
  RxString errorMsg = ''.obs;
  Dio dio = Dio();
  RxBool isloading = false.obs;
  GetStorage localDB = GetStorage();

  RxInt indexData = 0.obs;
  Rx<LatLng> latLng = LatLng(25.1572527, 55.4137894).obs;

  Location location = Location();
  late LocationData locationData;

  List<TextEditingController> locationEditing = [];

  List<TextEditingController> cachEditing = [];

  List<TextEditingController> phoneEditing = [];

  List<TextEditingController> nameEditing = [];

  List<TextEditingController> discrEditing = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    addForm();
  }

  addForm() {
    TextEditingController locationEditingItem = TextEditingController();

    TextEditingController cachEditingItem = TextEditingController();

    TextEditingController phoneEditingItem = TextEditingController();

    TextEditingController nameEditingItem = TextEditingController();

    TextEditingController discrEditingItem = TextEditingController();

    locationEditing.add(locationEditingItem);
    phoneEditing.add(phoneEditingItem);
    nameEditing.add(nameEditingItem);
    discrEditing.add(discrEditingItem);
    cachEditing.add(cachEditingItem);
    numberForm++;
    update();
  }

  removeForm(index) {
    locationEditing.removeAt(index);
    phoneEditing.removeAt(index);
    nameEditing.removeAt(index);
    discrEditing.removeAt(index);
    cachEditing.removeAt(index);

    numberForm--;
    update();
  }

  clear() {
    locationEditing.clear();
    phoneEditing.clear();
    nameEditing.clear();
    discrEditing.clear();
    cachEditing.clear();
    numberForm.value = 0;
    addForm();
  }

  Future<void> getLocationdata() async {
    runLoading();
    bool isServicesEnibl = false;
    late PermissionStatus permissionStatus;

    isServicesEnibl = await location.serviceEnabled();
    if (!isServicesEnibl) {
      isServicesEnibl = await location.requestService();
      if (!isServicesEnibl) {
        errorMsg(language[modeControll.LanguageValue]["isServicesNotEnibl"]);
      }
      stopLoading();
      return;
    }
    permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
      if (permissionStatus != PermissionStatus.granted) {
        errorMsg(language[modeControll.LanguageValue]["permissionStatus"]);
        stopLoading();

        return;
      }
    }

    locationData = await location.getLocation();
    stopLoading();
  }

  setLoaction(int index) {
    locationEditing[index].text =
        '${locationData.latitude},${locationData.longitude}';
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
  void error(String error) async {
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
      case "":
        break;
    }

    stopLoading();
  }
}
