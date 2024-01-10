import 'package:client_swift/UI/Body/Order/CreateOrderPage.dart';
import 'package:client_swift/UI/Body/Order/AddOrder.dart';
import 'package:client_swift/UI/Body/Order/OrderStat.dart';
import 'package:client_swift/UI/Body/Order/VehiclesPage.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:flutter/material.dart';

class OrderUI extends StatefulWidget {
  const OrderUI({super.key});

  @override
  State<OrderUI> createState() => _OrderUIState();
}

class _OrderUIState extends State<OrderUI> {
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageOrderController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        OrderState(),
        const addOrders(),
        const VehiclesPage(),
        const CreateOrderPage(),
      ],
    );
  }
}
