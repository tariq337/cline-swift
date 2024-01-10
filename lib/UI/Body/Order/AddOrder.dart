import 'package:client_swift/Controll/FormControll.dart';
import 'package:client_swift/Controll/OrderControll.dart';
import 'package:client_swift/UI/Map/MapPage.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/LoadeingPop.dart';
import 'package:client_swift/Widgets/Messge.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:client_swift/models/FirstOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Widgets/FormWidget.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:latlong2/latlong.dart';

class addOrders extends StatefulWidget {
  const addOrders({super.key});

  @override
  State<addOrders> createState() => _addOrdersState();
}

class _addOrdersState extends State<addOrders> {
  GetStorage localDB = GetStorage();
  FormControll controll = Get.put(FormControll(), permanent: true);
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return LoadeingPop(
          isLoageing: controll.isloading.value,
          child: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: pageFormController,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height - 32,
                  child: Stack(
                    children: [
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  TextUnit.TextButtonSpcfic(
                                      text: language[modeControll.LanguageValue]
                                          ["cancelOrder"],
                                      color: classColors.STATICS(
                                          modeControll.ThemeModeValue)[3],
                                      onTop: () {
                                        pageOrderController.animateToPage(0,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.linear);
                                      }),
                                  GetBuilder<OrderControll>(
                                      init: OrderControll(),
                                      builder: (orderControll) {
                                        return TextUnit.TextButtonSpcfic(
                                            text: language[modeControll
                                                .LanguageValue]["next"],
                                            onTop: () async {
                                              if (_formKey.currentState!
                                                      .validate() &&
                                                  localDB.hasData("location")) {
                                                controll.runLoading();
                                                List<Map<String, dynamic>>
                                                    firstOrderModel = [];
                                                for (var i = 0;
                                                    i <
                                                        controll
                                                            .numberForm.value;
                                                    i++) {
                                                  firstOrderModel.add(FirstOrderModel(
                                                          cash: double.parse(
                                                              (controll.cachEditing[i].text.isNotEmpty
                                                                      ? controll
                                                                          .cachEditing[
                                                                              i]
                                                                          .text
                                                                      : 0)
                                                                  .toString()),
                                                          description: controll
                                                                  .discrEditing[
                                                                      i]
                                                                  .text
                                                                  .isNotEmpty
                                                              ? controll
                                                                  .discrEditing[
                                                                      i]
                                                                  .text
                                                              : "",
                                                          point: controll
                                                              .locationEditing[i]
                                                              .text,
                                                          name: controll.nameEditing[i].text,
                                                          phoneNumber: controll.phoneEditing[i].text)
                                                      .toJson());
                                                }
                                                await orderControll
                                                    .postOrderFirst(
                                                        firstOrderModel:
                                                            firstOrderModel);

                                                controll.stopLoading();
                                                if (orderControll
                                                    .errorMsg.isNotEmpty) {
                                                  Messge.error(
                                                      orderControll
                                                          .errorMsg.value,
                                                      context);
                                                  orderControll.errorMsg("");
                                                } else {
                                                  controll.clear();
                                                  pageOrderController
                                                      .animateToPage(2,
                                                          duration:
                                                              const Duration(
                                                                  milliseconds:
                                                                      500),
                                                          curve: Curves.easeIn);
                                                }
                                              }
                                            });
                                      })
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              TextUnit.TextTitel(
                                  text: language[modeControll.LanguageValue]
                                      ["orderStaupOne"]),
                              const SizedBox(
                                height: 10,
                              ),
                              TextUnit.TextsubTitel(
                                  text: language[modeControll.LanguageValue]
                                      ["orderDetails"][4]),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                child: TextUnit.TextButtonSpcfic(
                                  onTop: () {
                                    pageController.animateToPage(4,
                                        duration:
                                            const Duration(milliseconds: 200),
                                        curve: Curves.linear);
                                  },
                                  color: localDB.hasData("location")
                                      ? classColors.STATICS(
                                          modeControll.ThemeModeValue)[0]
                                      : classColors.STATICS(
                                          modeControll.ThemeModeValue)[3],
                                  text: localDB.hasData("location")
                                      ? language[modeControll.LanguageValue]
                                          ["myLocation"]
                                      : language[modeControll.LanguageValue]
                                          ["noLocation"],
                                ),
                              ),
                              TextUnit.TextsubTitel(
                                  text: language[modeControll.LanguageValue]
                                      ["dataOrder"]),
                              for (int index = 0;
                                  index < controll.numberForm.value;
                                  index++)
                                FormWidget(
                                    onPressed: () {
                                      controll.indexData.value = index;
                                      if (controll.locationEditing[index].text
                                          .isNotEmpty) {
                                        List<String> lat = controll
                                            .locationEditing[index].text
                                            .split(",");
                                        controll.latLng.value = LatLng(
                                            double.parse(lat[0]),
                                            double.parse(lat[1]));
                                      }
                                      pageFormController.animateToPage(1,
                                          duration:
                                              const Duration(milliseconds: 500),
                                          curve: Curves.easeIn);
                                    },
                                    ifremove: controll.numberForm > 1,
                                    remove: () {
                                      controll.removeForm(index);
                                    },
                                    cachEditing: controll.cachEditing[index],
                                    locationEditing:
                                        controll.locationEditing[index],
                                    discrEditing: controll.discrEditing[index],
                                    nameEditing: controll.nameEditing[index],
                                    phoneEditing: controll.phoneEditing[index]),
                              const SizedBox(
                                height: 150,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: Responsive.isMobile(context) ? 90 : 16,
                        left: Responsive.isMobile(context) ? 26 : 16,
                        child: FloatingActionButton(
                            onPressed: () {
                              controll.addForm();
                            },
                            backgroundColor: classColors.bgColor,
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              const MapPage(),
            ],
          ),
        );
      }),
    );
  }
}
