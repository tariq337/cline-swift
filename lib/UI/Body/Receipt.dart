import 'dart:developer';

import 'package:client_swift/Controll/BillsControll.dart';
import 'package:client_swift/Controll/UserControll.dart';
import 'package:client_swift/Unit/ConverDate.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/LoadeingWidget.dart';
import 'package:client_swift/Widgets/Messge.dart';
import 'package:client_swift/Widgets/TableWidget.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:client_swift/models/BillsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReceiptUI extends StatefulWidget {
  const ReceiptUI({super.key});

  @override
  State<ReceiptUI> createState() => _ReceiptUIState();
}

class _ReceiptUIState extends State<ReceiptUI> {
  BillsControll billsControll = Get.put(BillsControll());

  bool isView = false;
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return LoadeingWidget(
        error: billsControll.errorMsg.value,
        isLoadeing: billsControll.isloading.value,
        reloade: () async {
          await billsControll.getBills();
        },
        child: Row(
          children: [
            Expanded(
              flex: 6,
              child: Container(
                  padding: const EdgeInsets.all(32),
                  margin: Responsive.isMobile(context)
                      ? null
                      : const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color:
                          classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                      borderRadius: BorderRadius.circular(11)),
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await billsControll.getBills();
                    },
                    child: ListView(
                      children: [
                        TableWidget(
                          onTopRow: (index) {
                            billsControll.setIndex(index);
                          },
                          titel: [
                            [
                              language[modeControll.LanguageValue]["bille"][0],
                              1,
                              true
                            ],
                            [
                              language[modeControll.LanguageValue]["bille"][1],
                              1,
                              true
                            ],
                            if (Responsive.isDesktop(context))
                              [
                                language[modeControll.LanguageValue]["bille"]
                                    [2],
                                1,
                                true
                              ],
                          ],
                          data: [
                            for (int index = 0;
                                index <
                                    (billsControll.billsModel.value.details ??
                                            [])
                                        .length;
                                index++)
                              [
                                Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: classColors.STATICS(
                                              modeControll.ThemeModeValue)[
                                          billsControll.billsModel.value
                                                  .details![index].state ??
                                              0 + 1]),
                                ),
                                TextUnit.TextsubTitel(
                                    text: convertDate(
                                        billsControll.billsModel.value
                                            .details![index].start!,
                                        false)),
                                if (Responsive.isDesktop(context))
                                  TextUnit.TextsubTitel(
                                      text: convertDate(
                                          billsControll.billsModel.value
                                                  .details![index].end ??
                                              "_",
                                          false)),
                              ]
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            if (!Responsive.isMobile(context) && billsControll.view.value)
              ReceiptDetails(
                  demand: () async {
                    billsControll.clear();
                    if (await billsControll.chickCard()) {
                      await billsControll.demand();
                    } else {
                      Messge.error(
                          language[modeControll.LanguageValue]["profileCard"],
                          context);
                    }
                  },
                  satisFied: () async {
                    billsControll.clear();
                    if (await billsControll.chickCard()) {
                      await billsControll.satisFied();
                    } else {
                      Messge.error(
                          language[modeControll.LanguageValue]["profileCard"],
                          context);
                    }
                  },
                  details: billsControll
                      .billsModel.value.details![billsControll.index.value],
                  clear: () {
                    log("jjj");
                    billsControll.clear();
                  })
          ],
        ),
      );
    });
  }
}

class ReceiptDetails extends StatefulWidget {
  Function clear;
  Details details;
  Function demand;
  Function satisFied;
  ReceiptDetails(
      {super.key,
      required this.clear,
      required this.details,
      required this.demand,
      required this.satisFied});

  @override
  State<ReceiptDetails> createState() => _ReceiptDetailsState();
}

class _ReceiptDetailsState extends State<ReceiptDetails> {
  @override
  Widget build(BuildContext context) {
    if (!Responsive.isMobile(context)) {
      return Expanded(
        flex: 3,
        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        widget.clear();
                      },
                      icon: const Icon(Icons.clear)),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (((widget.details.aloan ?? 0) -
                            (widget.details.bloan ?? 0)) !=
                        0 &&
                    widget.details.state == 0)
                  Align(
                    alignment: Alignment.topLeft,
                    child: ElevatedButton(
                      style: TextButton.styleFrom(
                        backgroundColor: classColors.bgColor,
                        padding: const EdgeInsets.all(
                          13,
                        ),
                      ),
                      onPressed: () {
                        if ((widget.details.bloan ?? 0) -
                                (widget.details.aloan ?? 0) >
                            0) {
                          widget.demand();
                        } else {
                          widget.satisFied();
                        }
                      },
                      child: TextUnit.Textsub(
                          text: language[modeControll.LanguageValue]["bille"][
                              ((widget.details.bloan ?? 0) -
                                          (widget.details.aloan ?? 0) >
                                      0)
                                  ? 6
                                  : 7],
                          color: Colors.white,
                          size: 11),
                    ),
                  ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TableWidget(titel: [
                    [language[modeControll.LanguageValue]["bille"][1], 1, true],
                    [convertDate(widget.details.start ?? "_", true), 1, true]
                  ], data: [
                    [
                      TextUnit.TextsubTitel(
                        text: language[modeControll.LanguageValue]["bille"][2],
                      ),
                      TextUnit.TextsubTitel(
                        text: convertDate(widget.details.end ?? "_", true),
                      ),
                    ],
                    [
                      TextUnit.TextsubTitel(
                        text: language[modeControll.LanguageValue]["bille"][0],
                      ),
                      Container(
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: classColors
                                    .STATICS(modeControll.ThemeModeValue)[
                                widget.details.state ?? 0 + 1]),
                      ),
                    ],
                    [
                      TextUnit.TextsubTitel(
                        text: language[modeControll.LanguageValue]["bille"][3],
                      ),
                      TextUnit.TextsubTitel(
                        text: widget.details.bloan.toString(),
                      ),
                    ],
                    [
                      TextUnit.TextsubTitel(
                        text: language[modeControll.LanguageValue]["bille"][4],
                      ),
                      TextUnit.TextsubTitel(
                        text: widget.details.aloan.toString(),
                      ),
                    ],
                    [
                      TextUnit.TextsubTitel(
                        text: language[modeControll.LanguageValue]["bille"][5],
                      ),
                      TextUnit.TextsubTitel(
                          text: ((widget.details.bloan ?? 0) -
                                  (widget.details.aloan ?? 0))
                              .toStringAsFixed(2),
                          color: (widget.details.bloan ?? 0) -
                                      (widget.details.aloan ?? 0) ==
                                  0
                              ? classColors
                                  .STATICS(modeControll.ThemeModeValue)[4]
                              : (widget.details.bloan ?? 0) -
                                          (widget.details.aloan ?? 0) >
                                      0
                                  ? classColors
                                      .STATICS(modeControll.ThemeModeValue)[2]
                                  : classColors
                                      .STATICS(modeControll.ThemeModeValue)[3]),
                    ],
                  ], onTopRow: (index) {}),
                ),
                if (Responsive.isMobile(context))
                  Container(
                    height: 150,
                    color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                  )
              ],
            ),
          ),
        ),
      );
    }
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  onPressed: () {
                    widget.clear();
                  },
                  icon: const Icon(Icons.clear)),
            ),
            const SizedBox(
              height: 5,
            ),
            if (((widget.details.aloan ?? 0) - (widget.details.bloan ?? 0)) !=
                    0 &&
                widget.details.state == 0)
              Align(
                alignment: Alignment.topLeft,
                child: ElevatedButton(
                  style: TextButton.styleFrom(
                    backgroundColor: classColors.bgColor,
                    padding: const EdgeInsets.all(
                      13,
                    ),
                  ),
                  onPressed: () {
                    if ((widget.details.bloan ?? 0) -
                            (widget.details.aloan ?? 0) >
                        0) {
                      widget.demand();
                    } else {
                      widget.satisFied();
                    }
                  },
                  child: TextUnit.Textsub(
                      text: language[modeControll.LanguageValue]["bille"][
                          ((widget.details.bloan ?? 0) -
                                      (widget.details.aloan ?? 0) >
                                  0)
                              ? 6
                              : 7],
                      color: Colors.white,
                      size: 11),
                ),
              ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: TableWidget(titel: [
                [language[modeControll.LanguageValue]["bille"][1], 1, true],
                [convertDate(widget.details.start ?? "_", true), 1, true]
              ], data: [
                [
                  TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["bille"][2],
                  ),
                  TextUnit.TextsubTitel(
                    text: convertDate(widget.details.end ?? "_", true),
                  ),
                ],
                [
                  TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["bille"][0],
                  ),
                  Container(
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: classColors.STATICS(modeControll.ThemeModeValue)[
                            widget.details.state ?? 0 + 1]),
                  ),
                ],
                [
                  TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["bille"][3],
                  ),
                  TextUnit.TextsubTitel(
                    text: widget.details.bloan.toString(),
                  ),
                ],
                [
                  TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["bille"][4],
                  ),
                  TextUnit.TextsubTitel(
                    text: widget.details.aloan.toString(),
                  ),
                ],
                [
                  TextUnit.TextsubTitel(
                    text: language[modeControll.LanguageValue]["bille"][5],
                  ),
                  TextUnit.TextsubTitel(
                      text: ((widget.details.bloan ?? 0) -
                              (widget.details.aloan ?? 0))
                          .toStringAsFixed(2),
                      color: (widget.details.bloan ?? 0) -
                                  (widget.details.aloan ?? 0) ==
                              0
                          ? classColors.STATICS(modeControll.ThemeModeValue)[4]
                          : (widget.details.bloan ?? 0) -
                                      (widget.details.aloan ?? 0) >
                                  0
                              ? classColors
                                  .STATICS(modeControll.ThemeModeValue)[2]
                              : classColors
                                  .STATICS(modeControll.ThemeModeValue)[3]),
                ],
              ], onTopRow: (index) {}),
            ),
            if (Responsive.isMobile(context))
              Container(
                height: 150,
                color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
              )
          ],
        ),
      ),
    );
  }
}
