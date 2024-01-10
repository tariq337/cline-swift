import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/OrderCardWidget.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:client_swift/models/StaticOrders.dart';
import 'package:flutter/material.dart';

class TitelOrder extends StatefulWidget {
  List<StaticOrderModel> staticsOrder;

  TitelOrder({super.key, required this.staticsOrder});
  @override
  State<TitelOrder> createState() => _TitelOrderState();
}

class _TitelOrderState extends State<TitelOrder> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextUnit.TextTitel(
                text: language[modeControll.LanguageValue]["titelStaticOrder"]),
            ElevatedButton.icon(
              style: TextButton.styleFrom(
                backgroundColor: classColors.bgColor,
                padding: const EdgeInsets.all(
                  13,
                ),
              ),
              onPressed: () {
                pageOrderController.animateToPage(1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.linear);
              },
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
              label: TextUnit.Textsub(
                  text: language[modeControll.LanguageValue]["addOrders"],
                  color: Colors.white,
                  size: 11),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Responsive(
          mobile: OrderCardGridView(
            staticsOrder: widget.staticsOrder,
            crossAxisCount: size.width < 650 ? 2 : 4,
            childAspectRatio: size.width < 650 && size.width > 350 ? 1.2 : 1,
          ),
          tablet: OrderCardGridView(staticsOrder: widget.staticsOrder),
          desktop: OrderCardGridView(
            staticsOrder: widget.staticsOrder,
            childAspectRatio: size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class OrderCardGridView extends StatelessWidget {
  OrderCardGridView(
      {Key? key,
      this.crossAxisCount = 4,
      this.childAspectRatio = 1,
      required this.staticsOrder})
      : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  List<StaticOrderModel> staticsOrder;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: staticsOrder.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) =>
          OrderCardWidget(staticOrderModel: staticsOrder[index]),
    );
  }
}
