import 'package:client_swift/Controll/StaticsControll.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/LoadeingWidget.dart';
import 'package:client_swift/Widgets/PieChartWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StaticesUI extends StatefulWidget {
  const StaticesUI({super.key});

  @override
  State<StaticesUI> createState() => _StaticesUIState();
}

class _StaticesUIState extends State<StaticesUI> {
  StaticsControll staticsControll = Get.put(StaticsControll());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      List<int> s1 = staticsControll.staticsModel.value.s1 ?? [0, 0, 0];
      List<int> s3 = staticsControll.staticsModel.value.s3 ?? [0, 0, 0];
      List<int> s4 = staticsControll.staticsModel.value.s4 ?? [0, 0, 0];
      List<int> s5 = staticsControll.staticsModel.value.s5 ?? [0, 0, 0];

      return LoadeingWidget(
        error: staticsControll.errorMsg.value,
        isLoadeing: staticsControll.isloading.value,
        reloade: () async {
          await staticsControll.getStatics();
        },
        child: RefreshIndicator(
          onRefresh: () async {
            await staticsControll.getStatics();
          },
          child: ListView(
            children: [
              Wrap(
                alignment: WrapAlignment.center,
                children: [
                  PieChartWidget(
                    color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                    titel: language[modeControll.LanguageValue]["dey"],
                    stats: [s1[0], s3[0], s4[0], s5[0]],
                  ),
                  SizedBox(
                      width: Responsive.isMobile(context)
                          ? null
                          : MediaQuery.of(context).size.width * .4,
                      child: PieChartWidget(
                        color:
                            classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                        titel: language[modeControll.LanguageValue]["month"],
                        stats: [s1[1], s3[1], s4[1], s5[1]],
                      )),
                  SizedBox(
                      width: Responsive.isMobile(context)
                          ? null
                          : MediaQuery.of(context).size.width * .4,
                      child: PieChartWidget(
                        color:
                            classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                        titel: language[modeControll.LanguageValue]["year"],
                        stats: [s1[2], s3[2], s4[2], s5[2]],
                      )),
                ],
              ),
              if (!Responsive.isMobile(context))
                const SizedBox(
                  height: 30,
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
    });
  }
}
