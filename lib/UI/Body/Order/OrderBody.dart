import 'package:client_swift/Unit/StaticColors.dart';
import 'package:client_swift/Unit/StaticName.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Widgets/TableWidget.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:client_swift/models/OrdersModel.dart';
import 'package:flutter/material.dart';

class OrderBody extends StatefulWidget {
  Function onTopRow;
  OrdersModel ordersModel;

  OrderBody({super.key, required this.onTopRow, required this.ordersModel});

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextUnit.TextsubTitel(
              text: language[modeControll.LanguageValue]["titelOrder"]),
          Container(
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: TableWidget(
                isObj: true,
                onTopRow: (dynamic obj) {
                  widget.onTopRow(obj);
                },
                titel: List.generate(3, (index) {
                  if (index == 0) {
                    return [
                      language[modeControll.LanguageValue]["Titeltable"][index],
                      0,
                      true
                    ];
                  }
                  return [
                    language[modeControll.LanguageValue]["Titeltable"][index],
                    1,
                    true
                  ];
                }),
                data: [
                  for (Details details in (widget.ordersModel.details ?? []))
                    for (int index = 1;
                        index < (details.points ?? []).length;
                        index++)
                      [
                        Container(
                          width: 70,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(7),
                          decoration: BoxDecoration(
                              color: StaticColors(
                                  ((details.points![index].state!.id ?? 0) == 3)
                                      ? (details.points![0].state!.id ?? 0)
                                      : details.points![index].state!.id ?? 0),
                              borderRadius: BorderRadius.circular(7)),
                          child: TextUnit.Textspcfic(
                              size: 9,
                              text: StaticName(
                                  ((details.points![index].state!.id ?? 0) == 3)
                                      ? (details.points![0].state!.id ?? 0)
                                      : details.points![index].state!.id ?? 0),
                              color: Colors.white),
                        ),
                        TextUnit.TextsubTitel(
                            text: details.points![index].name.toString(),
                            length: 10),
                        TextUnit.TextsubTitel(
                            text: (details.number ?? 0).toString()),
                        details
                      ]
                ]),
          )
        ],
      ),
    );
  }
}
