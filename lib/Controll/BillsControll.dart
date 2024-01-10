import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/models/BillsModel.dart';
import 'package:client_swift/models/ProfileModel.dart';
import 'package:client_swift/server/DioSever.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class BillsControll extends GetxController with DioServer {
  RxString errorMsg = "".obs;
  RxBool isloading = false.obs;
  Rx<BillsModel> billsModel = BillsModel().obs;
  Dio dio = Dio();
  GetStorage localDB = GetStorage();
  RxInt index = 0.obs;
  RxBool view = false.obs;

  int mindex = 0;
  bool mview = false;

  @override
  void onInit() {
    super.onInit();
    getBills();
  }

  Future<void> getBills() async {
    runLoading();
    await addApiKey();
    await get(dio: dio, url: unitUrl.bills, key: "getBills");
  }

  Future<void> satisFied() async {
    runLoading();
    await addApiKey();
    await get(dio: dio, url: unitUrl.satisFied, key: "satisFied");
  }

  Future<void> demand() async {
    runLoading();
    await addApiKey();
    await get(dio: dio, url: unitUrl.demand, key: "demand");
  }

  Future<void> sortBills() async {
    billsModel.value.details!.sort((a, b) {
      return a.state!.compareTo(b.state!);
    });
  }

  void setIndex(int index) {
    this.index(index);
    mindex = index;
    mview = true;
    view(true);
    update();
  }

  void clear() {
    view(false);
    mview = false;

    update();
  }

//add apiKey
  Future<void> addApiKey() async {
    dio.options.headers['apiKey'] = await localDB.read("apiKey");
  }

  Future<bool> chickCard() async {
    CardsModel cardsModel = CardsModel.fromJson(await localDB.read("cards"));

    if ((cardsModel.cardCvv ?? "").isNotEmpty &&
        (cardsModel.cardName ?? "").isNotEmpty &&
        (cardsModel.cardNumber ?? "").isNotEmpty &&
        compareDates((cardsModel.cardExDateYear ?? 2000).toString(),
            (cardsModel.cardExDateMonth ?? 1).toString())) {
      return true;
    } else {
      return false;
    }
  }

  bool compareDates(String year, String month) {
    DateTime currentDate = DateTime.now();
    DateTime selectedDate = DateTime(int.parse(year), int.parse(month));

    return currentDate.isBefore(selectedDate);
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

    switch (key) {
      case "getBills":
        billsModel(BillsModel.fromJson(data));
        await sortBills();
        break;
      case "satisFied":
        await getBills();
        break;
      case "demand":
        await getBills();
        break;
    }

    stopLoading();
  }
}
