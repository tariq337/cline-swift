import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PieChartWidget extends StatefulWidget {
  String titel;
  Color color;
  List<int> stats;

  PieChartWidget(
      {super.key,
      required this.titel,
      required this.stats,
      required this.color});

  @override
  State<PieChartWidget> createState() => _PieChartWidgetState();
}

class _PieChartWidgetState extends State<PieChartWidget> {
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        padding: const EdgeInsets.all(16),
        margin: Responsive.isMobile(context) ? null : const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: widget.color, borderRadius: BorderRadius.circular(11)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextUnit.TextTitel(text: widget.titel),
            const SizedBox(height: 16),
            Chart(stats: widget.stats),
            StorageInfoCard(
              title: language[modeControll.LanguageValue]["staticOrders"][1],
              numOfFiles: widget.stats[0],
              color: classColors.STATICS(modeControll.ThemeModeValue)[0],
            ),
            StorageInfoCard(
              title: language[modeControll.LanguageValue]["staticOrders"][3],
              numOfFiles: widget.stats[1],
              color: classColors.STATICS(modeControll.ThemeModeValue)[1],
            ),
            StorageInfoCard(
              title: language[modeControll.LanguageValue]["staticOrders"][4],
              numOfFiles: widget.stats[2],
              color: classColors.STATICS(modeControll.ThemeModeValue)[2],
            ),
            StorageInfoCard(
              title: language[modeControll.LanguageValue]["staticOrders"][5],
              numOfFiles: widget.stats[3],
              color: classColors.STATICS(modeControll.ThemeModeValue)[3],
            ),
          ],
        ),
      );
    });
  }
}

class Chart extends StatelessWidget {
  List<int> stats;
  Chart({
    required this.stats,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: <PieChartSectionData>[
                PieChartSectionData(
                  color: classColors.STATICS(modeControll.ThemeModeValue)[0],
                  value: stats[0].toDouble(),
                  showTitle: false,
                  radius: 25,
                ),
                PieChartSectionData(
                  color: classColors.STATICS(modeControll.ThemeModeValue)[1],
                  value: stats[1].toDouble(),
                  showTitle: false,
                  radius: 22,
                ),
                PieChartSectionData(
                  color: classColors.STATICS(modeControll.ThemeModeValue)[2],
                  value: stats[2].toDouble(),
                  showTitle: false,
                  radius: 19,
                ),
                PieChartSectionData(
                  color: classColors.STATICS(modeControll.ThemeModeValue)[3],
                  value: stats[3].toDouble(),
                  showTitle: false,
                  radius: 16,
                ),
              ],
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextUnit.TextTitel(
                    text: "${stats[0] + stats[1] + stats[2] + stats[3]}")
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<PieChartSectionData> paiChartSelectionData = [];

class StorageInfoCard extends StatelessWidget {
  const StorageInfoCard(
      {Key? key,
      required this.title,
      required this.numOfFiles,
      required this.color})
      : super(key: key);

  final String title;
  final int numOfFiles;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: color.withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextUnit.TextsubTitel(text: title),
            ),
          ),
          TextUnit.TextsubTitel(text: numOfFiles.toString())
        ],
      ),
    );
  }
}
