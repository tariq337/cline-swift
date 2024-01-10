import 'package:client_swift/Controll/UserControll.dart';
import 'package:client_swift/UI/Body/User/CreditCard.dart';
import 'package:client_swift/UI/Body/User/LoginPage.dart';
import 'package:client_swift/UI/Body/User/addCreditCard.dart';
import 'package:client_swift/UI/Map/MapLocation.dart';
import 'package:client_swift/Unit/Url.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Widgets/BottomSheetDilog.dart';
import 'package:client_swift/Widgets/LoadeingPop.dart';
import 'package:client_swift/Widgets/Messge.dart';
import 'package:client_swift/Widgets/TextEditingDialog.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:client_swift/models/ProfileModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUI extends StatefulWidget {
  const ProfileUI({super.key});

  @override
  State<ProfileUI> createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  UserControll userControll = Get.put(UserControll());
  final _formKey = GlobalKey<FormState>();
  TextEditingController textName = TextEditingController();
  TextEditingController textEmail = TextEditingController();
  TextEditingController textPhone = TextEditingController();

  TextEditingController textCardName = TextEditingController();
  TextEditingController textCardNumber = TextEditingController();
  TextEditingController textCardMonth = TextEditingController();
  TextEditingController textCardyear = TextEditingController();
  TextEditingController textCardCvv = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (userControll.errorMsg.value.isNotEmpty) {
        userControll.errorMsg.value = "";
      } else {
        textCardCvv.text = userControll.profileModel.value.cardCvv ?? "****";
        textCardMonth.text =
            "${userControll.profileModel.value.cardExDateMonth ?? ""}";
        textCardyear.text =
            "${userControll.profileModel.value.cardExDateYear ?? ""}";
        textCardName.text = userControll.profileModel.value.cardName ?? "";
        textCardNumber.text =
            userControll.profileModel.value.cardNumber ?? "XXXXXXXXXXXXXXXX";
      }
      return Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: LoadeingPop(
          isLoageing: userControll.isloading.value,
          child: Align(
            alignment: Alignment.center,
            child: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageUsrtController,
              children: [
                Container(
                  height: Responsive.isMobile(context)
                      ? MediaQuery.of(context).size.height
                      : null,
                  width: Responsive.isMobile(context)
                      ? MediaQuery.of(context).size.width
                      : MediaQuery.of(context).size.width * .5,
                  padding: const EdgeInsets.all(16),
                  child: PageView(
                    controller: pageProfileController,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                onTap: () async {
                                  bool camera = false;
                                  bool studio = false;
                                  await BottomSheetDilog(
                                      context: context,
                                      onCameraClick: () {
                                        camera = true;
                                        Navigator.of(context).pop();
                                      },
                                      onStudioClick: () {
                                        studio = true;
                                        Navigator.of(context).pop();
                                      });
                                  if (camera) {
                                    final picker = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    if (picker == null) {
                                      Messge.notification(
                                          language[modeControll.LanguageValue]
                                              ["noImage"],
                                          context);
                                    } else {
                                      await userControll.putProfileImage(
                                          key: "imageUrl",
                                          fileName: picker.path.split('/').last,
                                          filePath: picker.path);
                                    }
                                  } else if (studio) {
                                    final picker = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (picker == null) {
                                      Messge.notification(
                                          language[modeControll.LanguageValue]
                                              ["noImage"],
                                          context);
                                    } else {
                                      await userControll.putProfileImage(
                                          key: "imageUrl",
                                          fileName: picker.path.split('/').last,
                                          filePath: picker.path);
                                    }
                                  }

                                  if (userControll.errorMsg.value.isNotEmpty) {
                                    Messge.error(
                                        userControll.errorMsg.value, context);
                                  } else {
                                    Messge.notification(
                                        language[modeControll.LanguageValue]
                                            ["done"],
                                        context);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(16),
                                  height: 100,
                                  decoration: BoxDecoration(
                                      color: classColors.NEUTRAL(
                                          modeControll.ThemeModeValue)[4],
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: modeControll.ThemeModeValue
                                              ? Colors.black12
                                              : Colors.white12,
                                          width: 1.5),
                                      image: (userControll.profileModel.value.imageUrl ??
                                                  "")
                                              .isEmpty
                                          ? null
                                          : DecorationImage(
                                              image: NetworkImage(
                                                  unitUrl.imageUrl(userControll
                                                          .profileModel
                                                          .value
                                                          .imageUrl ??
                                                      "")))),
                                  child: (userControll.profileModel.value
                                                  .imageUrl ??
                                              "")
                                          .isEmpty
                                      ? Icon(
                                          Icons.perm_identity,
                                          size: 65,
                                          color: modeControll.ThemeModeValue
                                              ? Colors.black54
                                              : Colors.white54,
                                        )
                                      : null,
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () async {
                                  pageUsrtController.animateToPage(1,
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeIn);
                                },
                                child: Container(
                                  height: 55,
                                  width: Responsive.isMobile(context)
                                      ? MediaQuery.of(context).size.width
                                      : MediaQuery.of(context).size.width * .55,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: classColors.NEUTRAL(
                                          modeControll.ThemeModeValue)[4],
                                      borderRadius: BorderRadius.circular(11)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerRight,
                                        width: Responsive.isMobile(context)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .3,
                                        height: 40,
                                        child: TextUnit.TextsubTitel(
                                            text: language[modeControll
                                                .LanguageValue]["myLocation"],
                                            maxLines: 1),
                                      ),
                                      const Icon(
                                        Icons.location_on_rounded,
                                        color: classColors.bgColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    color: classColors.NEUTRAL(
                                        modeControll.ThemeModeValue)[4],
                                    borderRadius: BorderRadius.circular(11)),
                                child: Column(
                                  children: [
                                    ItemWidget(
                                        title:
                                            language[modeControll.LanguageValue]
                                                ["auth"][4],
                                        text: userControll
                                                .profileModel.value.name ??
                                            "",
                                        onTap: () async {
                                          textName.text = "";
                                          bool chick = false;
                                          await TextEditingDialog(
                                              textInputType: TextInputType.name,
                                              context: context,
                                              title: language[modeControll
                                                  .LanguageValue]["auth"][4],
                                              hintText: language[modeControll
                                                  .LanguageValue]["auth"][4],
                                              controller: textName,
                                              onClickOK: (String text) async {
                                                textName.text = text;
                                                chick = true;
                                                Navigator.of(context).pop();
                                              },
                                              onClickNotOK: () {
                                                chick = false;
                                                Navigator.of(context).pop();
                                              });
                                          if (chick) {
                                            await userControll.putProfile(
                                                data: {"name": textName.text});
                                            if (userControll
                                                .errorMsg.value.isNotEmpty) {
                                              Messge.error(
                                                  userControll.errorMsg.value,
                                                  context);
                                            } else {
                                              Messge.notification(
                                                  language[modeControll
                                                      .LanguageValue]["done"],
                                                  context);
                                            }
                                          }
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ItemWidget(
                                        title:
                                            language[modeControll.LanguageValue]
                                                ["auth"][5],
                                        text: userControll
                                                .profileModel.value.email ??
                                            "",
                                        onTap: () async {
                                          textEmail.text = "";
                                          bool chick = false;
                                          await TextEditingDialog(
                                              textInputType:
                                                  TextInputType.emailAddress,
                                              context: context,
                                              title: language[modeControll
                                                  .LanguageValue]["auth"][5],
                                              hintText: language[modeControll
                                                  .LanguageValue]["auth"][5],
                                              controller: textEmail,
                                              onClickOK: (String text) async {
                                                textEmail.text = text;
                                                chick = true;
                                                Navigator.of(context).pop();
                                              },
                                              onClickNotOK: () {
                                                chick = false;
                                                Navigator.of(context).pop();
                                              });
                                          if (chick) {
                                            await userControll.putProfile(
                                                data: {
                                                  "email": textEmail.text
                                                });
                                            if (userControll
                                                .errorMsg.value.isNotEmpty) {
                                              Messge.error(
                                                  userControll.errorMsg.value,
                                                  context);
                                            } else {
                                              Messge.notification(
                                                  language[modeControll
                                                      .LanguageValue]["done"],
                                                  context);
                                            }
                                          }
                                        }),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    ItemWidget(
                                        title:
                                            language[modeControll.LanguageValue]
                                                ["auth"][9],
                                        text: userControll.profileModel.value
                                                .phoneNumber ??
                                            "",
                                        onTap: () async {
                                          textPhone.text = "";
                                          bool chick = false;
                                          await TextEditingDialog(
                                              context: context,
                                              title: language[modeControll
                                                  .LanguageValue]["auth"][9],
                                              hintText: language[modeControll
                                                  .LanguageValue]["auth"][9],
                                              controller: textPhone,
                                              textInputType:
                                                  TextInputType.phone,
                                              onClickOK: (String text) async {
                                                textPhone.text = text;
                                                chick = true;
                                                Navigator.of(context).pop();
                                              },
                                              onClickNotOK: () {
                                                chick = false;
                                                Navigator.of(context).pop();
                                              });
                                          if (chick) {
                                            await userControll.putProfile(
                                                data: {
                                                  "phoneNumber": textPhone.text
                                                });
                                            if (userControll
                                                .errorMsg.value.isNotEmpty) {
                                              Messge.error(
                                                  userControll.errorMsg.value,
                                                  context);
                                            } else {
                                              Messge.notification(
                                                  language[modeControll
                                                      .LanguageValue]["done"],
                                                  context);
                                            }
                                          }
                                        }),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              InkWell(
                                onTap: () async {
                                  GetStorage localDB = GetStorage();
                                  await localDB.remove("apiKey");
                                  Get.deleteAll();
                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              const LoginPage()),
                                      (Route<dynamic> route) => false);
                                },
                                child: Container(
                                  height: 55,
                                  width: Responsive.isMobile(context)
                                      ? MediaQuery.of(context).size.width
                                      : MediaQuery.of(context).size.width * .55,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: classColors.NEUTRAL(
                                          modeControll.ThemeModeValue)[4],
                                      borderRadius: BorderRadius.circular(11)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: modeControll.LanguageValue
                                            ? Alignment.centerRight
                                            : Alignment.centerLeft,
                                        width: Responsive.isMobile(context)
                                            ? MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .6
                                            : MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                .3,
                                        height: 40,
                                        child: TextUnit.TextsubTitel(
                                            text: language[modeControll
                                                .LanguageValue]["logout"],
                                            maxLines: 1),
                                      ),
                                      const Icon(
                                        Icons.logout,
                                        color: classColors.bgColor,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: Responsive.isMobile(context)
                                    ? MediaQuery.of(context).size.width
                                    : MediaQuery.of(context).size.width * .5,
                                child: Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                          onPressed: () {
                                            pageProfileController.animateToPage(
                                                1,
                                                duration: const Duration(
                                                    milliseconds: 200),
                                                curve: Curves.linear);
                                          },
                                          icon: const Icon(
                                            Icons.mode,
                                            color: classColors.bgColor,
                                          )),
                                    ),
                                    CreditCard(
                                        isback: false,
                                        Cvv: textCardCvv.text,
                                        month: textCardMonth.text,
                                        year: textCardyear.text,
                                        cardName: textCardName.text,
                                        cardNumber: textCardNumber.text),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              if (Responsive.isMobile(context))
                                const SizedBox(
                                  height: 150,
                                )
                            ],
                          ),
                        ),
                      ),
                      addCreditCard(
                          onSave: (CardsModel cardsModel) async {
                            await userControll.putProfile(
                                data: cardsModel.toJson());
                            if (userControll.errorMsg.value.isNotEmpty) {}
                            pageProfileController.animateToPage(0,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.linear);
                          },
                          textCardName: textCardName,
                          textCardNumber: textCardNumber,
                          textCardyear: textCardyear,
                          textCardMonth: textCardMonth,
                          textCardCvv: textCardCvv)
                    ],
                  ),
                ),
                const MapLocation()
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget ItemWidget(
      {required String title, String? text, required void Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width
            : MediaQuery.of(context).size.width * .5,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
            color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
            borderRadius: BorderRadius.circular(7)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Responsive.isMobile(context)
                  ? MediaQuery.of(context).size.width * .6
                  : MediaQuery.of(context).size.width * .3,
              child: TextUnit.TextsubTitel(text: text ?? title),
            ),
            const Icon(
              Icons.navigate_next_outlined,
              color: classColors.bgColor,
              size: 27,
            ),
          ],
        ),
      ),
    );
  }
}
