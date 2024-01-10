import 'package:client_swift/UI/Body/User/CreditCard.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/TextFieldWidget.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:client_swift/models/ProfileModel.dart';
import 'package:flutter/material.dart';

class addCreditCard extends StatefulWidget {
  TextEditingController textCardName;
  TextEditingController textCardNumber;
  TextEditingController textCardMonth;
  TextEditingController textCardyear;
  TextEditingController textCardCvv;
  Function onSave;
  addCreditCard(
      {super.key,
      required this.textCardName,
      required this.textCardNumber,
      required this.textCardyear,
      required this.textCardMonth,
      required this.textCardCvv,
      required this.onSave});

  @override
  State<addCreditCard> createState() => _addCreditCardState();
}

class _addCreditCardState extends State<addCreditCard> {
  final _formKey = GlobalKey<FormState>();

  bool isback = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        pageProfileController.animateToPage(0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear);
                      },
                      icon: const Icon(Icons.clear)),
                  const SizedBox(
                    width: 1,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width
                  : MediaQuery.of(context).size.width * .5,
              child: CreditCard(
                  isback: isback,
                  Cvv: widget.textCardCvv.text,
                  month: widget.textCardMonth.text,
                  year: widget.textCardyear.text,
                  cardName: widget.textCardName.text,
                  cardNumber: widget.textCardNumber.text),
            ),
            const SizedBox(
              height: 16,
            ),
            TextFieldWidget(
                border: true,
                color: Colors.green[50],
                circleBorder: true,
                ontap: () {
                  if (isback) {
                    setState(() {
                      isback = false;
                    });
                  }
                },
                onchanged: (v) {
                  setState(() {});
                },
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width * .9
                    : MediaQuery.of(context).size.width * .4,
                validator: (String? v) {
                  if (v == null || v.isEmpty) {
                    return language[modeControll.LanguageValue]["authError"][0];
                  }
                  return null;
                },
                textInputType: TextInputType.name,
                textEditingController: widget.textCardName,
                text: language[modeControll.LanguageValue]["auth"][4]),
            const SizedBox(
              height: 5,
            ),
            TextFieldWidget(
                border: true,
                color: Colors.green[50],
                circleBorder: true,
                max: 16,
                ontap: () {
                  if (isback) {
                    setState(() {
                      isback = false;
                    });
                  }
                },
                onchanged: (v) {
                  setState(() {});
                },
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width * .9
                    : MediaQuery.of(context).size.width * .4,
                validator: (String? v) {
                  if (v == null || v.isEmpty) {
                    return language[modeControll.LanguageValue]["authError"][0];
                  }
                  return null;
                },
                textInputType: TextInputType.number,
                textEditingController: widget.textCardNumber,
                text: language[modeControll.LanguageValue]["auth"][10]),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width * .9
                  : MediaQuery.of(context).size.width * .4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: TextFieldWidget(
                        border: true,
                        circleBorder: true,
                        color: Colors.green[50],
                        max: 2,
                        onchanged: (v) {
                          setState(() {});
                        },
                        ontap: () {
                          if (isback) {
                            setState(() {
                              isback = false;
                            });
                          }
                        },
                        width: (Responsive.isMobile(context)
                                ? MediaQuery.of(context).size.width * .9
                                : MediaQuery.of(context).size.width * .4) *
                            .5,
                        validator: (String? v) {
                          if (v == null || v.isEmpty) {
                            return language[modeControll.LanguageValue]
                                ["authError"][0];
                          }
                          return null;
                        },
                        textInputType: TextInputType.number,
                        textEditingController: widget.textCardMonth,
                        text: language[modeControll.LanguageValue]["month"]),
                  ),
                  const Expanded(
                      flex: 1,
                      child: SizedBox(
                        width: 1,
                      )),
                  Expanded(
                    flex: 4,
                    child: TextFieldWidget(
                        border: true,
                        color: Colors.green[50],
                        circleBorder: true,
                        max: 4,
                        width: (Responsive.isMobile(context)
                                ? MediaQuery.of(context).size.width * .9
                                : MediaQuery.of(context).size.width * .4) *
                            .5,
                        validator: (String? v) {
                          if (v == null || v.isEmpty) {
                            return language[modeControll.LanguageValue]
                                ["authError"][0];
                          }
                          return null;
                        },
                        onchanged: (v) {
                          setState(() {});
                        },
                        ontap: () {
                          if (isback) {
                            setState(() {
                              isback = false;
                            });
                          }
                        },
                        textInputType: TextInputType.number,
                        textEditingController: widget.textCardyear,
                        text: language[modeControll.LanguageValue]["year"]),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width * .9
                  : MediaQuery.of(context).size.width * .4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFieldWidget(
                      border: true,
                      circleBorder: true,
                      max: 4,
                      color: Colors.green[50],
                      onchanged: (v) {
                        setState(() {});
                      },
                      ontap: () {
                        if (!isback) {
                          setState(() {
                            isback = true;
                          });
                        }
                      },
                      width: Responsive.isMobile(context)
                          ? MediaQuery.of(context).size.width * .4
                          : MediaQuery.of(context).size.width * .2,
                      validator: (String? v) {
                        if (v == null || v.isEmpty) {
                          return language[modeControll.LanguageValue]
                              ["authError"][0];
                        }
                        return null;
                      },
                      textInputType: TextInputType.number,
                      textEditingController: widget.textCardCvv,
                      text: language[modeControll.LanguageValue]["auth"][11]),
                  const SizedBox(
                    width: 1,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () async {
                if (_formKey.currentState!.validate()) {
                  CardsModel cardsModel = CardsModel(
                      cardCvv: widget.textCardCvv.text,
                      cardExDateMonth: int.parse(widget.textCardMonth.text),
                      cardExDateYear: int.parse(widget.textCardyear.text),
                      cardName: widget.textCardName.text,
                      cardNumber: widget.textCardNumber.text);
                  await widget.onSave(cardsModel);
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 13),
                width: Responsive.isMobile(context)
                    ? MediaQuery.of(context).size.width * .7
                    : MediaQuery.of(context).size.width * .4,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: classColors.bgColor,
                    borderRadius: BorderRadius.circular(11)),
                child: TextUnit.Textsub(
                    text: language[modeControll.LanguageValue]["done"],
                    color: Colors.white,
                    size: 14),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
