import 'package:client_swift/Unit/ConverDate.dart';
import 'package:client_swift/Unit/StaticColors.dart';
import 'package:client_swift/Unit/StaticName.dart';
import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Widgets/ImageWidget.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:client_swift/models/OrdersModel.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderDetails extends StatefulWidget {
  Details orders;
  Function clear;
  Function refresh;
  Function() delet;
  Function() openMap;

  OrderDetails(
      {super.key,
      required this.openMap,
      required this.delet,
      required this.orders,
      required this.clear,
      required this.refresh});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  bool getStat() {
    int x = 0;
    for (var element in widget.orders.points!) {
      if (element.state!.id == 0) {
        x = 1;
        continue;
      }
    }
    if (x == 1) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if ((widget.orders.points![0].state!.id ?? 0) == 0 ||
                (widget.orders.points![0].state!.id ?? 0) == 1)
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    onPressed: widget.delet,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (getStat())
                    IconButton(
                        onPressed: () {
                          widget.refresh(widget.orders.id);
                        },
                        icon: const Icon(Icons.refresh)),
                  IconButton(
                      onPressed: () {
                        widget.clear();
                      },
                      icon: const Icon(Icons.clear)),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["orderDetails"]
                        [0]),
                TextUnit.TextsubTitel(
                    text: (widget.orders.number ?? 0).toString()),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["orderDetails"]
                        [1]),
                TextUnit.TextsubTitel(
                    text: (widget.orders.agent == null
                            ? "_"
                            : widget.orders.agent!.name ?? "_")
                        .toString()),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["orderDetails"]
                        [12]),
                (widget.orders.agent == null)
                    ? TextUnit.TextsubTitel(text: "_")
                    : (widget.orders.agent!.imageUrl == null)
                        ? TextUnit.TextsubTitel(text: "_")
                        : ImageWidget(
                            image: widget.orders.agent!.imageUrl!,
                            height: 70,
                            width: 70,
                          )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["orderDetails"]
                        [3]),
                TextUnit.TextButtonSpcfic(
                    onTop: () async {
                      if (widget.orders.agent != null) {
                        if (widget.orders.agent!.phoneNumber != null) {
                          await _makePhoneCall(
                              widget.orders.agent!.phoneNumber!);
                        }
                      }
                    },
                    color: Colors.blue,
                    size: 14,
                    text: (widget.orders.agent == null
                            ? "_"
                            : widget.orders.agent!.phoneNumber ?? "_")
                        .toString()),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["orderDetails"]
                        [2]),
                TextUnit.TextsubTitel(
                    text: (widget.orders.delivery == null
                            ? "_"
                            : widget.orders.delivery!.name ?? "_")
                        .toString()),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["orderDetails"]
                        [12]),
                (widget.orders.delivery == null)
                    ? TextUnit.TextsubTitel(text: "_")
                    : (widget.orders.delivery!.imageUrl == null)
                        ? TextUnit.TextsubTitel(text: "_")
                        : (widget.orders.delivery == null)
                            ? TextUnit.TextsubTitel(text: "_")
                            : (widget.orders.delivery!.imageUrl == null)
                                ? TextUnit.TextsubTitel(text: "_")
                                : ImageWidget(
                                    image: widget.orders.delivery!.imageUrl!,
                                    height: 70,
                                    width: 70,
                                  )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["orderDetails"]
                        [3]),
                TextUnit.TextButtonSpcfic(
                    onTop: () async {
                      if (widget.orders.delivery != null) {
                        if (widget.orders.delivery!.phoneNumber != null) {
                          await _makePhoneCall(
                              widget.orders.delivery!.phoneNumber!);
                        }
                      }
                    },
                    color: Colors.blue,
                    size: 14,
                    text: (widget.orders.delivery == null
                            ? "_"
                            : widget.orders.delivery!.phoneNumber ?? "_")
                        .toString()),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["orderDetails"]
                        [4]),
                TextUnit.TextButtonSpcfic(
                    onTop: () async {
                      if (widget.orders.delivery != null) {
                        if (widget.orders.delivery!.location != null) {
                          widget.openMap();
                        }
                      }
                    },
                    color: Colors.blue,
                    size: 14,
                    text: (widget.orders.delivery == null
                            ? "_"
                            : widget.orders.delivery!.location == null
                                ? "_"
                                : language[modeControll.LanguageValue]
                                    ["orderDetails"][5])
                        .toString()),
              ],
            ),
            Divider(
              color: modeControll.ThemeModeValue ? Colors.black : Colors.white,
              height: 20,
            ),
            for (int index = 1;
                index < (widget.orders.points ?? []).length;
                index++)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextUnit.TextsubTitel(
                          text: language[modeControll.LanguageValue]
                              ["orderDetails"][6]),
                      Container(
                        width: 70,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(7),
                        decoration: BoxDecoration(
                            color: StaticColors(
                                (widget.orders.points![index].state!.id ?? 0) ==
                                        3
                                    ? widget.orders.points![0].state!.id ?? 0
                                    : widget.orders.points![index].state!.id ??
                                        0),
                            borderRadius: BorderRadius.circular(7)),
                        child: TextUnit.Textspcfic(
                            size: 9,
                            text: StaticName(
                                (widget.orders.points![index].state!.id ?? 0) ==
                                        3
                                    ? widget.orders.points![0].state!.id ?? 0
                                    : widget.orders.points![index].state!.id ??
                                        0),
                            color: Colors.white),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextUnit.TextsubTitel(
                          text: language[modeControll.LanguageValue]
                              ["orderDetails"][7]),
                      TextUnit.TextsubTitel(
                          text: convertDate(
                              widget.orders.points![index].state == null
                                  ? "_"
                                  : widget.orders.points![index].state!
                                          .timestamp ??
                                      "_",
                              true)),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextUnit.TextsubTitel(
                          text: language[modeControll.LanguageValue]
                              ["orderDetails"][8]),
                      TextUnit.TextsubTitel(
                          text: widget.orders.points![index].name ?? ""),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextUnit.TextsubTitel(
                          text: language[modeControll.LanguageValue]
                              ["orderDetails"][9]),
                      TextUnit.TextsubTitel(
                          text: (widget.orders.points![index].cash ?? "_")
                              .toString()),
                    ],
                  ),
                  Divider(
                    color: modeControll.ThemeModeValue
                        ? Colors.black
                        : Colors.white,
                    height: 20,
                  ),
                ],
              )
          ],
        ),
      ),
    );
  }
}



/* 



             DataTable(columnSpacing: 3, horizontalMargin: 2, columns: [
              DataColumn(
                label: TextUnit.TextsubTitel(text:
                  language[modeControll.LanguageValue]["Titeltable"][3],
                  ,
                ),
              ),
              DataColumn(
                label: TextUnit.TextsubTitel(text:"${widget.orders.number}",
                    ),
              ),
            ], rows: [
              DataRow(cells: [
               ]),
              DataRow(cells: [
                DataCell(TextUnit.TextsubTitel(text:language[modeControll.LanguageValue]["Titeltable"][1],
                    )),
                DataCell(TextUnit.TextsubTitel(text:"${widget.orders.name}",
                    )),
              ]),
              DataRow(cells: [
               /////
               
                ]),
              DataRow(cells: [
               ]),
              DataRow(cells: [
                DataCell(TextUnit.TextsubTitel(text:language[modeControll.LanguageValue]["dateOrders"][1],
                    )),
                DataCell(TextUnit.TextsubTitel(text:"${widget.orders.date}",
                    )),
              ]),
              DataRow(cells: [
                DataCell(TextUnit.TextsubTitel(text:
                    widget.orders.statics == language[modeControll.LanguageValue]["staticOrders"][3]
                        ? language[modeControll.LanguageValue]["dateOrders"][4]
                        : language[modeControll.LanguageValue]["dateOrders"][3],
                    )),
                DataCell(TextUnit.TextsubTitel(text:"${widget.orders.dateend}",
                    )),
              ]),
            ]),
 */