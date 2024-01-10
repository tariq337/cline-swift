import 'package:client_swift/Unit/StaticColors.dart';
import 'package:client_swift/Unit/StaticName.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';

Future<void> BottomSheetView(
    {required BuildContext context,
    required String name,
    String? description,
    String? email,
    required String phoneNumber,
    required int state,
    required bool isCline,
    required Function() onPhone}) async {
  return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Directionality(
          textDirection: modeControll.LanguageValue
              ? TextDirection.rtl
              : TextDirection.ltr,
          child: Container(
            decoration: BoxDecoration(
              color: classColors.NEUTRAL(modeControll.ThemeModeValue)[3],
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  topRight: Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: 5,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.black54),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 1,
                      ),
                      Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              color: StaticColors(state).withOpacity(.7),
                              borderRadius: BorderRadius.circular(4)),
                          child: TextUnit.Textspcfic(
                            size: 11,
                            color: Colors.white,
                            text: StaticName(state),
                          )),
                    ],
                  ),
                ),
                // ImageWidget(image: ""),

                const Icon(
                  Icons.image_not_supported_outlined,
                  size: 41,
                  color: Colors.black54,
                ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                  child: ListTile(
                    leading:
                        const Icon(Icons.person, color: classColors.bgColor),
                    title: TextUnit.TextsubTitel(
                      text: name,
                    ),
                  ),
                ),
                if (!isCline)
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                    child: ListTile(
                      leading: const Icon(Icons.description,
                          color: classColors.bgColor),
                      title: TextUnit.TextsubTitel(text: description ?? email!),
                    ),
                  ),

                Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
                  child: ListTile(
                      leading:
                          const Icon(Icons.phone, color: classColors.bgColor),
                      title: TextUnit.TextsubTitel(
                          color: classColors.bgColor, text: phoneNumber),
                      onTap: onPhone),
                ),

                const SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        );
      });
}
