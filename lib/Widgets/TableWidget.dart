import 'dart:developer';

import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class TableWidget extends StatefulWidget {
  List<List<dynamic>> titel;
  List<List<dynamic>> data;
  Function(dynamic) onTopRow;
  bool? isObj;
  TableWidget(
      {super.key,
      this.isObj,
      required this.titel,
      required this.data,
      required this.onTopRow});

  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.titel.length, (index) {
            if (widget.titel[index][1] == 0) {
              return Visibility(
                visible: widget.titel[index][2],
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: SizedBox(
                    width: 70,
                    child: TextUnit.Textspcfic(
                        text: widget.titel[index][0].toString(),
                        maxLines: 1,
                        fontWeight: FontWeight.bold,
                        color: modeControll.ThemeModeValue
                            ? Colors.black87
                            : Colors.white70,
                        size: 15),
                  ),
                ),
              );
            }
            return Visibility(
              visible: widget.titel[index][2],
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextUnit.Textspcfic(
                    text: widget.titel[index][0].toString(),
                    maxLines: 1,
                    fontWeight: FontWeight.bold,
                    color: modeControll.ThemeModeValue
                        ? Colors.black87
                        : Colors.white70,
                    size: 15),
              ),
            );
          }),
        ),
        const Divider(),
        for (int i = 0; i < widget.data.length; i++)
          dataTable(
              isObj: widget.isObj ?? false,
              data: widget.data,
              onTopRow: widget.onTopRow,
              titel: widget.titel,
              i: i)
      ],
    );
  }
}

class dataTable extends StatefulWidget {
  List<List<dynamic>> titel;
  List<List<dynamic>> data;
  Function(dynamic) onTopRow;
  bool isObj;
  int i;
  dataTable(
      {super.key,
      required this.isObj,
      required this.data,
      required this.onTopRow,
      required this.titel,
      required this.i});

  @override
  State<dataTable> createState() => _dataTableState();
}

class _dataTableState extends State<dataTable> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onHover: (v) {
            setState(() {
              hover = v;
            });
          },
          onTap: () {
            if (widget.isObj) {
              log(widget.data[widget.i][3].toString());
              widget.onTopRow(
                  widget.data[widget.i][widget.data[widget.i].length - 1]);
            } else {
              widget.onTopRow(widget.i);
            }
          },
          child: Container(
            color: hover
                ? (classColors.NEUTRAL(modeControll.ThemeModeValue)[3])
                    .withOpacity(.2)
                : null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(widget.titel.length, (index) {
                return Visibility(
                  visible: widget.titel[index][2],
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: hover ? 10 : 5),
                      child: widget.data[widget.i][index]),
                );
              }),
            ),
          ),
        ),
        const Divider()
      ],
    );
  }
}
