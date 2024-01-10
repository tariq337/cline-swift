import 'dart:developer';

import 'package:client_swift/Controll/BillsControll.dart';
import 'package:client_swift/Controll/OrderControll.dart';
import 'package:client_swift/UI/Body/Order/Order.dart';
import 'package:client_swift/UI/Body/Order/OrderDetails.dart';
import 'package:client_swift/UI/Body/User/Profile.dart';
import 'package:client_swift/UI/Body/Receipt.dart';
import 'package:client_swift/UI/Body/Statices.dart';
import 'package:client_swift/UI/Body/Notification.dart';
import 'package:client_swift/UI/Map/MapScreen.dart';
import 'package:client_swift/UI/NavigationBar.dart';

import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Unit/language.dart';
import '../../Widgets/Messge.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  BillsControll billsControll = Get.put(BillsControll());
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            if (!Responsive.isDesktop(context)) const Header(),
            Expanded(
              child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  scrollDirection: Responsive.isMobile(context)
                      ? Axis.horizontal
                      : Axis.vertical,
                  children: const [
                    OrderUI(),
                    StaticesUI(),
                    ReceiptUI(),
                    NotificationUI(),
                    ProfileUI(),
                  ]),
            ),
          ],
        ),
        if (Responsive.isMobile(context))
          Obx(() {
            return Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: NavigationBarWidget(
                  navBtn: [
                    [
                      language[modeControll.LanguageValue]["titelOrder"],
                      "assets/icons/menu_dashboard.svg"
                    ],
                    [
                      language[modeControll.LanguageValue]["static"],
                      "assets/icons/menu_tran.svg"
                    ],
                    [
                      language[modeControll.LanguageValue]["receipt"],
                      "assets/icons/menu_doc.svg",
                    ],
                    [
                      language[modeControll.LanguageValue]["notification"],
                      "assets/icons/menu_notification.svg",
                    ],
                    [
                      language[modeControll.LanguageValue]["users"],
                      "assets/icons/menu_profile.svg",
                    ]
                  ],
                ));
          }),
        GetBuilder<OrderControll>(
            init: OrderControll(),
            builder: (controll) {
              return Visibility(
                visible: (Responsive.isMobile(context) && controll.isView),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  color: Colors.black.withOpacity(.5),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: OrderDetails(
                    openMap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              MapScreen(ordersDetails: controll.order.value)));
                    },
                    delet: () async {
                      controll.clear();

                      await controll.orderDelet(controll.order.value.id!);
                    },
                    refresh: (String id) {
                      controll.refreshOrders(id: id);
                      controll.clear();
                      pageOrderController.animateToPage(2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                    },
                    clear: () {
                      controll.clear();
                    },
                    orders: controll.order.value,
                  ),
                ),
              );
            }),
        GetBuilder<BillsControll>(
            init: BillsControll(),
            builder: (controller) {
              if ((Responsive.isMobile(context) && billsControll.mview)) {
                return Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(16),
                  color: Colors.black.withOpacity(.4),
                  child: ReceiptDetails(
                      demand: () async {
                        billsControll.clear();
                        if (await billsControll.chickCard()) {
                          await billsControll.demand();
                        } else {
                          Messge.error(
                              language[modeControll.LanguageValue]
                                  ["profileCard"],
                              context);
                        }
                      },
                      satisFied: () async {
                        billsControll.clear();
                        if (await billsControll.chickCard()) {
                          await billsControll.satisFied();
                        } else {
                          Messge.error(
                              language[modeControll.LanguageValue]
                                  ["profileCard"],
                              context);
                        }
                      },
                      details: (billsControll.billsModel.value.details ??
                          [])[billsControll.mindex],
                      clear: () {
                        billsControll.clear();
                      }),
                );
              }
              return Visibility(
                  visible: (Responsive.isMobile(context) &&
                      billsControll.view.value),
                  child: Container());
            })
      ],
    );
  }
}
