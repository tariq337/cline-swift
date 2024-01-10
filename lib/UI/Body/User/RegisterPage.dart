import 'package:client_swift/Controll/AuthControll.dart';
import 'package:client_swift/UI/Body/User/LoginPage.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/LoadeingPop.dart';
import 'package:client_swift/Widgets/Messge.dart';
import 'package:client_swift/Widgets/TextFieldWidget.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController textName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPassword1 = TextEditingController();

  TextEditingController textPassword2 = TextEditingController();

  bool validateEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:
          modeControll.LanguageValue ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        backgroundColor: classColors.NEUTRAL(modeControll.ThemeModeValue)[2],
        body: GetBuilder<AuthControll>(
            init: AuthControll(),
            builder: (controll) {
              return Container(
                alignment: Alignment.center,
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: LoadeingPop(
                  isLoageing: controll.isloading,
                  child: Align(
                    alignment: Alignment.center,
                    child: Form(
                      key: _formKey,
                      child: SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.center,
                          height: Responsive.isMobile(context)
                              ? MediaQuery.of(context).size.height
                              : null,
                          width: Responsive.isMobile(context)
                              ? MediaQuery.of(context).size.width
                              : MediaQuery.of(context).size.width * .6,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                              color: classColors
                                  .NEUTRAL(modeControll.ThemeModeValue)[4],
                              borderRadius: BorderRadius.circular(11)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              const FlutterLogo(
                                size: 61,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextUnit.TextTitel(
                                  text: language[modeControll.LanguageValue]
                                      ["auth"][0]),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.person,
                                    color: classColors.bgColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextFieldWidget(
                                      color: Colors.green[50],
                                      border: true,
                                      circleBorder: true,
                                      width: Responsive.isMobile(context)
                                          ? MediaQuery.of(context).size.width *
                                              .8
                                          : MediaQuery.of(context).size.width *
                                              .4,
                                      validator: (String? v) {
                                        if (v == null || v.isEmpty) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][0];
                                        }
                                        return null;
                                      },
                                      textInputType: TextInputType.name,
                                      textEditingController: textName,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][4]),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.email_rounded,
                                    color: classColors.bgColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextFieldWidget(
                                      color: Colors.green[50],
                                      border: true,
                                      circleBorder: true,
                                      width: Responsive.isMobile(context)
                                          ? MediaQuery.of(context).size.width *
                                              .8
                                          : MediaQuery.of(context).size.width *
                                              .4,
                                      validator: (String? v) {
                                        if (v == null || v.isEmpty) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][0];
                                        } else if (!validateEmail(
                                            textEmail.text)) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][1];
                                        }
                                        return null;
                                      },
                                      textInputType: TextInputType.emailAddress,
                                      textEditingController: textEmail,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][5]),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.lock,
                                    color: classColors.bgColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextFieldWidget(
                                      color: Colors.green[50],
                                      border: true,
                                      circleBorder: true,
                                      width: Responsive.isMobile(context)
                                          ? MediaQuery.of(context).size.width *
                                              .8
                                          : MediaQuery.of(context).size.width *
                                              .4,
                                      validator: (String? v) {
                                        if (v == null || v.isEmpty) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][0];
                                        } else if (v.length < 8) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][2];
                                        } else if (textPassword1.text !=
                                            textPassword2.text) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][3];
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      length: 1,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      textEditingController: textPassword1,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][6]),
                                ],
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.lock,
                                    color: classColors.bgColor,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  TextFieldWidget(
                                      color: Colors.green[50],
                                      border: true,
                                      circleBorder: true,
                                      width: Responsive.isMobile(context)
                                          ? MediaQuery.of(context).size.width *
                                              .8
                                          : MediaQuery.of(context).size.width *
                                              .4,
                                      validator: (String? v) {
                                        if (v == null || v.isEmpty) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][0];
                                        } else if (v.length < 8) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][2];
                                        } else if (textPassword1.text !=
                                            textPassword2.text) {
                                          return language[modeControll
                                              .LanguageValue]["authError"][3];
                                        }
                                        return null;
                                      },
                                      obscureText: true,
                                      length: 1,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      textEditingController: textPassword2,
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][7]),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              TextUnit.TextButtonSpcfic(
                                  color: classColors.bgColor,
                                  text: language[modeControll.LanguageValue]
                                      ["auth"][2],
                                  onTop: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                const LoginPage()),
                                        (Route<dynamic> route) => false);
                                  }),
                              const SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      modeControll.languageToggle();

                                      setState(() {});
                                    },
                                    icon: const Icon(
                                      Icons.language,
                                      color: classColors.bgColor,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 7,
                              ),
                              InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    await controll.register(
                                        userName: textName.text,
                                        email: textEmail.text,
                                        password: textPassword1.text);
                                    if (controll.errorMsg.isNotEmpty) {
                                      Messge.error(controll.errorMsg, context);
                                    } else {
                                      Messge.notification(
                                          language[modeControll.LanguageValue]
                                              ["emaillMessage"],
                                          context,
                                          color: classColors.STATICS(
                                              modeControll.ThemeModeValue)[2]);

                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  const LoginPage()),
                                          (Route<dynamic> route) => false);
                                    }
                                  }
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 13),
                                  width: Responsive.isMobile(context)
                                      ? MediaQuery.of(context).size.width * .7
                                      : MediaQuery.of(context).size.width * .4,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: classColors.bgColor,
                                      borderRadius: BorderRadius.circular(11)),
                                  child: TextUnit.Textsub(
                                      text: language[modeControll.LanguageValue]
                                          ["auth"][8],
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
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
