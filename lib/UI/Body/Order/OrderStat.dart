import 'package:client_swift/Controll/OrderControll.dart';
import 'package:client_swift/UI/Body/Order/OrderBody.dart';
import 'package:client_swift/UI/Body/Order/OrderDetails.dart';
import 'package:client_swift/UI/Body/Order/TitelOrder.dart';
import 'package:client_swift/UI/Map/MapScreen.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/LoadeingWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Unit/const.dart';

class OrderState extends StatelessWidget {
  OrderState({
    super.key,
  });
  OrderControll controll = Get.put(OrderControll());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: RefreshIndicator(
          onRefresh: () async {
            await controll.getOrders();
          },
          child: LoadeingWidget(
            error: controll.errorMsg.value,
            isLoadeing: controll.isloading.value,
            reloade: () async {
              await controll.getOrders();
            },
            child: Row(
              children: [
                Expanded(
                  flex: 7,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: RefreshIndicator(
                      onRefresh: () async {
                        await controll.getOrders();
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 16,
                            ),
                            TitelOrder(
                              staticsOrder: controll.staticOrder(),
                            ),
                            const SizedBox(height: 16),
                            OrderBody(
                                ordersModel: controll.ordersModel.value,
                                onTopRow: (obj) {
                                  controll.setdata(obj);
                                }),
                            const SizedBox(
                              height: 16,
                            ),
                            if (Responsive.isMobile(context))
                              const SizedBox(
                                height: 150,
                              )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: (!Responsive.isMobile(context) &&
                      controll.isViewobx.value),
                  child: Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: OrderDetails(
                          openMap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MapScreen(
                                    ordersDetails: controll.order.value)));
                          },
                          delet: () async {
                            controll.clear();

                            await controll.orderDelet(controll.order.value.id!);
                          },
                          refresh: (String id) {
                            controll.refreshOrders(id: id);
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
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
