import 'dart:developer';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:client_swift/Controll/CreateOrderControll.dart';
import 'package:client_swift/Controll/OrderControll.dart';
import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/ImageWidget.dart';
import 'package:client_swift/Widgets/LoadeingPop.dart';
import 'package:client_swift/Widgets/LoadeingWidget.dart';
import 'package:client_swift/Widgets/Messge.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  CreateOrderControll controll = Get.put(CreateOrderControll());
  OrderControll orderControll = Get.put(OrderControll());
  final MapController _mapController = MapController();
  @override
  void initState() {
    super.initState();
    controll.getAgints(vehiclesId: orderControll.vehiclesId.value);
    controll.getDelivery(vehiclesId: orderControll.vehiclesId.value);
    getlocaion();
  }

  LatLng? mylocaion;
  getlocaion() async {
    mylocaion = await controll.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => LoadeingPop(
          isLoageing: controll.isloading.value,
          child: Stack(
            children: [
              LoadeingWidget(
                isLoadeing: controll.isloadingDelivery.value,
                error: controll.errorMsgDelivery.value,
                reloade: () async {
                  await controll.getDelivery(
                      vehiclesId: orderControll.vehiclesId.value);
                },
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: mylocaion ?? LatLng(25.1572527, 55.4137894),
                    zoom: 16.0,
                    maxZoom: 18,
                    minZoom: 2,
                    onTap: (tapPosition, point) {},
                  ),
                  nonRotatedChildren: [
                    MarkerLayer(markers: [
                      Marker(
                        point: mylocaion ?? LatLng(25.1572527, 55.4137894),
                        rotateAlignment: AlignmentDirectional.topCenter,
                        rotateOrigin: const Offset(1, 1),
                        rotate: true,
                        builder: (ctx) => AvatarGlow(
                          duration: const Duration(milliseconds: 600),
                          glowColor: classColors.bgColor,
                          repeat: true,
                          startDelay: const Duration(milliseconds: 600),
                          child: Container(
                            height: 30,
                            alignment: Alignment.center,
                            decoration: const BoxDecoration(
                                color: classColors.bgColor,
                                shape: BoxShape.circle),
                            child: const Icon(
                              Icons.shopping_bag_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      for (int index = 0;
                          index <
                              (controll.deliveryModel.value.details ?? [])
                                  .length;
                          index++)
                        Marker(
                            point: LatLng(
                                double.parse(controll.deliveryModel.value
                                    .details![index].location!
                                    .split(",")[0]),
                                double.parse(controll.deliveryModel.value
                                    .details![index].location!
                                    .split(",")[1])),
                            rotateAlignment: AlignmentDirectional.topCenter,
                            rotateOrigin: const Offset(1, 1),
                            rotate: true,
                            builder: (ctx) => AvatarGlow(
                                  duration: const Duration(milliseconds: 600),
                                  glowColor: classColors.bgColor,
                                  repeat: true,
                                  startDelay: const Duration(milliseconds: 600),
                                  child: Container(
                                    height: 30,
                                    alignment: Alignment.center,
                                    decoration: const BoxDecoration(
                                        color: classColors.bgColor,
                                        shape: BoxShape.circle),
                                    child: const Icon(
                                      Icons.drive_eta,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                )),
                    ])
                  ],
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token={accessToken}',
                      additionalOptions: const {
                        'accessToken':
                            'pk.eyJ1IjoidGFyaXEzMzciLCJhIjoiY2xuYXNqOGRsMDcycDJqbzM0eWluZ3ozMCJ9.NJDsZTYoyoPN5zLXOZlhLQ',
                        'id': 'mapbox/outdoors-v12',
                      },
                    ),
                  ],
                ),
              ),
              if (controll.isView.value)
                Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width * .5,
                  decoration: BoxDecoration(
                      color:
                          classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                      borderRadius: BorderRadius.circular(11)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              controll.clear();
                            },
                          ),
                          IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () async {
                                await controll.postOrderScond(
                                    orderId: orderControll.orderId.value,
                                    agintsId: "",
                                    deliveryId: controll
                                            .deliveryModel
                                            .value
                                            .details![controll.index.value]
                                            .id ??
                                        "",
                                    vehiclesId: orderControll.vehiclesId.value);
                                if (controll.errorMsg.value.isNotEmpty) {
                                  Messge.error(
                                      controll.errorMsg.value, context);
                                  controll.errorMsg("");
                                } else {
                                  orderControll.getOrders();
                                  pageOrderController.animateToPage(0,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                }
                              }),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if ((controll
                                      .deliveryModel
                                      .value
                                      .details![controll.index.value]
                                      .imageUrl ??
                                  "")
                              .isNotEmpty)
                            Container(
                              height: 80,
                              width: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: NetworkImage(unitUrl.imageUrl(
                                          "${controll.deliveryModel.value.details![controll.index.value].imageUrl}")))),
                            ),
                          TextUnit.TextsubTitel(
                              text:
                                  "${controll.deliveryModel.value.details![controll.index.value].name}")
                        ],
                      ),
                    ],
                  ),
                ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                      color:
                          classColors.NEUTRAL(modeControll.ThemeModeValue)[3],
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30))),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () async {
                            await controll.postOrderScond(
                                orderId: orderControll.orderId.value,
                                agintsId: "",
                                deliveryId: "",
                                vehiclesId: orderControll.vehiclesId.value);
                            if (controll.errorMsg.value.isNotEmpty) {
                              Messge.error(controll.errorMsg.value, context);
                              controll.errorMsg("");
                            } else {
                              orderControll.getOrders();
                              pageOrderController.animateToPage(0,
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            width: Responsive.isMobile(context)
                                ? MediaQuery.of(context).size.width * .5
                                : MediaQuery.of(context).size.width * .4,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: classColors.bgColor,
                                borderRadius: BorderRadius.circular(11)),
                            child: TextUnit.Textsub(
                                text: language[modeControll.LanguageValue]
                                    ["done"],
                                color: Colors.white,
                                size: 14),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      LoadeingWidget(
                        error: controll.errorMsgAgints.value,
                        isLoadeing: controll.isloadingAgints.value,
                        reloade: () async {
                          controll.getDelivery(
                              vehiclesId: orderControll.vehiclesId.value);

                          await controll.getAgints(
                              vehiclesId: orderControll.vehiclesId.value);
                        },
                        child: SizedBox(
                          height: 120,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: List.generate(
                                (controll.agentModel.value.details ?? [])
                                    .length,
                                (index) => Padding(
                                      padding: const EdgeInsets.only(
                                          right: 5, left: 5, bottom: 26),
                                      child: InkWell(
                                        onTap: () async {
                                          await controll.postOrderScond(
                                              orderId:
                                                  orderControll.orderId.value,
                                              agintsId: controll
                                                      .agentModel
                                                      .value
                                                      .details![index]
                                                      .id ??
                                                  "",
                                              deliveryId: "",
                                              vehiclesId: orderControll
                                                  .vehiclesId.value);
                                          if (controll
                                              .errorMsg.value.isNotEmpty) {
                                            Messge.error(
                                                controll.errorMsg.value,
                                                context);
                                            controll.errorMsg("");
                                          } else {
                                            orderControll.getOrders();
                                            pageOrderController.animateToPage(0,
                                                duration: const Duration(
                                                    milliseconds: 500),
                                                curve: Curves.easeIn);
                                          }
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                              color: classColors.NEUTRAL(
                                                  modeControll
                                                      .ThemeModeValue)[4],
                                              borderRadius:
                                                  BorderRadius.circular(11)),
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                ImageWidget(
                                                  image: controll
                                                          .agentModel
                                                          .value
                                                          .details![index]
                                                          .imageUrl ??
                                                      "",
                                                  height: 80,
                                                  width: 80,
                                                ),
                                                TextUnit.TextsubTitel(
                                                    text: controll
                                                            .agentModel
                                                            .value
                                                            .details![index]
                                                            .name ??
                                                        "")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      )
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      pageOrderController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    icon: const Icon(Icons.clear)),
              ),
            ],
          ),
        ));
  }
}
