import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class CreditCard extends StatefulWidget {
  bool isback;
  String cardNumber;
  String cardName;
  String Cvv;
  String month;
  String year;
  CreditCard(
      {super.key,
      this.isback = false,
      required this.cardName,
      required this.cardNumber,
      required this.Cvv,
      required this.year,
      required this.month});

  @override
  State<CreditCard> createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      padding: const EdgeInsets.all(20),
      duration: const Duration(milliseconds: 600),
      height: Responsive.isMobile(context) ? 170 : 230,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: widget.isback ? Colors.yellow : Colors.red,
          gradient: const LinearGradient(colors: [
            Color(0xFF2F31A3),
            classColors.bgColor,
            Color(0xFF2F31A3),
          ], begin: Alignment.bottomLeft, end: Alignment.centerRight)),
      transformAlignment: Alignment.center,
      transform: widget.isback ? Matrix4.rotationX(3.14) : Matrix4.rotationX(0),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 600),
        reverseDuration: const Duration(milliseconds: 600),
        child: widget.isback
            ? Transform.rotate(
                angle: 3.14,
                child: Column(
                  children: [
                    Container(
                      height: 40,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Container(
                            color: Colors.grey,
                            height: 40,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
                            height: 30,
                            color: Colors.white,
                            alignment: Alignment.bottomCenter,
                            child: TextUnit.TextTitel(
                                text: "* " * (widget.Cvv.length),
                                color: Colors.black),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      SizedBox(
                        height: 1,
                      ),
                      Icon(
                        Icons.wifi,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  const Spacer(),
                  Row(children: [
                    Image.asset(
                      "assets/image/chip.png",
                      width: 40,
                    ),
                    const Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Expanded(
                        flex: 7,
                        child: TextUnit.TextTitel(
                            maxLines: 1,
                            textAlign: modeControll.LanguageValue
                                ? TextAlign.start
                                : TextAlign.end,
                            text:
                                "${CardNumber(widget.cardNumber)[0].join("")} ${CardNumber(widget.cardNumber)[1].join("")} ${CardNumber(widget.cardNumber)[2].join("")} ${CardNumber(widget.cardNumber)[3].join("")}",
                            color: Colors.white),
                      ),
                    )
                  ]),
                  const Spacer(),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextUnit.Textspcfic(
                                size: 13,
                                text: language[modeControll.LanguageValue]
                                    ["date"],
                                color: Colors.white),
                            TextUnit.Textspcfic(
                                size: 10,
                                text: "${widget.month}/${widget.year}",
                                color: Colors.white),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextUnit.Textspcfic(
                                size: 13,
                                text: language[modeControll.LanguageValue]
                                    ["auth"][4],
                                color: Colors.white),
                            TextUnit.Textspcfic(
                                size: 13,
                                text: widget.cardName,
                                color: Colors.white),
                          ],
                        ),
                      ]),
                ],
              ),
      ),
    );
  }

  List<List<String>> CardNumber(String num) {
    List<String> number = [
      "X", //0
      "X", //1
      "X", //2
      "X", //3

      "X", //4
      "X", //5
      "X", //6
      "X", //7

      "X", //8
      "X", //9
      "X", //10
      "X", //11

      "X", //12
      "X", //13
      "X", //14
      "X" //15
    ];

    for (int i = 0; i < num.length; i++) {
      if (8 > i || i > 11 && i < 16) {
        number[i] = num[i];
      }
    }

    return [
      number.sublist(0, 4),
      number.sublist(4, 8),
      number.sublist(8, 12),
      number.sublist(12, 16)
    ];
  }
}
