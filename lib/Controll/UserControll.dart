import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:client_swift/models/ProfileModel.dart';
import 'package:client_swift/server/DioSever.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:dio/src/form_data.dart' as formdara;
import 'package:dio/src/multipart_file.dart' as multipart;

class UserControll extends GetxController with DioServer {
  RxString errorMsg = ''.obs;
  Rx<LatLng> latLng = LatLng(25.1572527, 55.4137894).obs;
  RxBool isloading = false.obs;
  Rx<ProfileModel> profileModel = ProfileModel().obs;
  Rx<CardsModel> cardsModel = CardsModel().obs;

  Dio dio = Dio();
  GetStorage localDB = GetStorage();

  Location location = Location();
  late LocationData locationData;

  Future<void> getProfile() async {
    runLoading();
    await addApiKey();

    await get(dio: dio, url: unitUrl.profile, key: "getProfile");
  }

  Future<void> putProfile({required Object data}) async {
    runLoading();
    await addApiKey();
    put(dio: dio, url: unitUrl.profile, key: "putProfile", data: data);
  }

  Future<void> putProfileImage(
      {required String key,
      required String fileName,
      required String filePath}) async {
    runLoading();
    await addApiKey();
    put(
        dio: dio,
        url: unitUrl.profile,
        key: "putProfile",
        data: formdara.FormData.fromMap({
          "image": await multipart.MultipartFile.fromFile(filePath,
              filename: fileName),
          "taill": "png"
        }));
  }

  Future<void> getLocationdata() async {
    bool isServicesEnibl = false;
    late PermissionStatus permissionStatus;

    isServicesEnibl = await location.serviceEnabled();
    if (!isServicesEnibl) {
      isServicesEnibl = await location.requestService();
      if (!isServicesEnibl) {
        errorMsg(language[modeControll.LanguageValue]["isServicesNotEnibl"]);
        stopLoading();
        return;
      }
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

    latLng(LatLng(locationData.latitude!, locationData.longitude!));
  }

  setLoaction() async {
    await putProfile(data: {
      "location": '${latLng.value.latitude},${latLng.value.longitude}'
    });
  }

  @override
  void onInit() {
    super.onInit();
    getProfile();
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
      case "getProfile":
        profileModel(ProfileModel.fromJson(data));
        cardsModel(CardsModel.fromJson(data));
        await localDB.write("cards", cardsModel.value.toJson());
        await localDB.write("location", profileModel.value.location);
        await localDB.write("profile", profileModel.value.toJson());
        break;
      case "putProfile":
        await getProfile();
        break;
    }

    stopLoading();
  }
}
