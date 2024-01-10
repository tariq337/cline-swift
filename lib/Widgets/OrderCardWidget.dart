import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/models/StaticOrders.dart';
import 'package:flutter/material.dart';

class OrderCardWidget extends StatelessWidget {
  final StaticOrderModel staticOrderModel;
  const OrderCardWidget({super.key, required this.staticOrderModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: const EdgeInsets.all(7),
              decoration: BoxDecoration(
                border: Border.all(
                    color: staticOrderModel.color!.withOpacity(0.4), width: 1),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: TextUnit.Textsub(
                  text: staticOrderModel.title!,
                  color: staticOrderModel.color,
                  size: 10)),
          TextUnit.Textsub(text: staticOrderModel.title!),
          ProgressLine(
            color: staticOrderModel.color,
            percentage: staticOrderModel.percentage,
            totel: staticOrderModel.numOfOrders,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextUnit.Textsub(
                  text:
                      "${staticOrderModel.percentage} ${language[modeControll.LanguageValue]["order"]}"),
              TextUnit.Textsub(
                  text:
                      "${staticOrderModel.numOfOrders}/${staticOrderModel.percentage}"),
            ],
          )
        ],
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key? key,
    this.color = classColors.bgColor,
    required this.percentage,
    required this.totel,
  }) : super(key: key);

  final Color? color;
  final int? percentage;
  final int? totel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 5,
          decoration: BoxDecoration(
            color: color!.withOpacity(0.1),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
        ),
        LayoutBuilder(
          builder: (context, constraints) => Container(
            width: constraints.maxWidth *
                (percentage! / (totel == 0 ? 1 : totel)!),
            height: 5,
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
          ),
        ),
      ],
    );
  }
}
