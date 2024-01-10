import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget TextFieldWidget(
    {required TextInputType textInputType,
    int? length,
    int? max,
    Color? color,
    double? height,
    double? width,
    bool? border,
    bool? circleBorder,
    Widget? widget,
    List<TextInputFormatter>? inputFormatters,
    void Function()? ontap,
    void Function(String)? onchanged,
    String? Function(String?)? validator,
    bool? obscureText,
    required TextEditingController textEditingController,
    required String text}) {
  return Container(
      height: height,
      width: width,
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        border: (border ?? false)
            ? null
            : Border.all(
                color: modeControll.ThemeModeValue
                    ? Colors.black12
                    : Colors.white12,
                width: 1),
      ),
      child: TextFormField(
          scrollPadding: const EdgeInsets.all(0),
          inputFormatters: inputFormatters,
          onTap: ontap,
          onChanged: onchanged,
          controller: textEditingController,
          keyboardType: textInputType,
          obscureText: obscureText ?? false,
          minLines: length,
          maxLines: length,
          maxLength: max,
          validator: validator,
          style: TextStyle(
              fontFamily: TextUnit.textFonts,
              color: modeControll.ThemeModeValue
                  ? Colors.black54
                  : Colors.white54),
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              errorStyle: TextStyle(
                fontSize: TextInputType.phone == textInputType ? 12 : null,
                fontFamily: TextUnit.textFonts,
                color: classColors.STATICS(modeControll.ThemeModeValue)[3],
              ),
              icon: widget,
              suffix: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: InkWell(
                  onTap: () {
                    textEditingController.text = "";
                  },
                  child: const Icon(
                    Icons.clear,
                    size: 15,
                  ),
                ),
              ),
              hintStyle: TextStyle(
                  fontFamily: TextUnit.textFonts,
                  fontSize: 13,
                  color: modeControll.ThemeModeValue
                      ? Colors.black54
                      : Colors.white54),
              hintText: text,
              enabledBorder: (border ?? false)
                  ? (circleBorder ?? false)
                      ? const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))
                      : null
                  : InputBorder.none,
              errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: .3)),
              focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.redAccent, width: .3)),
              focusedBorder: (border ?? false)
                  ? (circleBorder ?? false)
                      ? const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent))
                      : null
                  : InputBorder.none,
              filled: true,
              fillColor: modeControll.ThemeModeValue
                  ? const Color(0x07000000)
                  : Colors.white10)));
}




  /* return SizedBox(
    width: width,
    height: height,
    child: Column(
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: color,
                border: (border ?? false)
                    ? null
                    : Border.all(color: Colors.black12, width: 1),
                borderRadius: BorderRadius.circular(4)),
            child: TextFormField(
                onTap: ontap,
                onChanged: onchanged,
                controller: textEditingController,
                keyboardType: textInputType,
                minLines: length,
                maxLines: length,
                maxLength: max,
                validator: validator,
                style: TextStyle(
                    fontSize: TextInputType.phone == textInputType ? 12 : null,
                    fontFamily: TextUnit.textFonts,
                    color: Colors.black54),
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontSize: TextInputType.phone == textInputType ? 12 : null,
                    fontFamily: TextUnit.textFonts,
                    color: classColors.STATICS[3],
                  ),
                  icon: widget,
                  suffix: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: InkWell(
                      onTap: () {
                        textEditingController.text = "";
                      },
                      child: const Icon(
                        Icons.clear,
                        size: 15,
                      ),
                    ),
                  ),
                  labelStyle: const TextStyle(
                      fontFamily: TextUnit.textFonts,
                      fontSize: 13,
                      color: Colors.black54),
                  labelText: text,
                  border: (border ?? false)
                      ? (circleBorder ?? false)
                          ? const OutlineInputBorder()
                          : null
                      : InputBorder.none,
                )),
          ),
        ),
      ],
    ),
  ); */

