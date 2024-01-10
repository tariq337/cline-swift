import 'package:client_swift/Unit/const.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class TextUnit {
  static const String textFonts = "Cairo";

  static TextTitel(
          {required String text,
          Color? color,
          TextAlign? textAlign,
          int? maxLines}) =>
      AutoSizeText(
        text,
        minFontSize: 5,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
            fontFamily: textFonts,
            fontSize: 17,
            color: color ??
                (modeControll.ThemeModeValue ? Colors.black : Colors.white),
            fontWeight: FontWeight.bold),
      );

  static TextNormle({required String text, Color? color, double? size}) => Text(
        text,
        style: TextStyle(
            fontFamily: textFonts,
            fontSize: size,
            color: color ??
                (modeControll.ThemeModeValue ? Colors.black : Colors.white),
            fontWeight: FontWeight.bold),
      );

  static TextButtonSpcfic(
          {required String text,
          Color? color,
          double? size,
          required Function onTop}) =>
      TextButton(
        onPressed: () {
          onTop();
        },
        child: AutoSizeText(
          text,
          minFontSize: 5,
          style: TextStyle(
              fontFamily: textFonts,
              fontSize: size ?? 15,
              color: color ??
                  (modeControll.ThemeModeValue ? Colors.black : Colors.white),
              fontWeight: FontWeight.bold),
        ),
      );
  static TextsubTitel(
          {required String text,
          TextAlign? textAlign,
          Color? color,
          int? length,
          int? maxLines}) =>
      AutoSizeText(
        text.length >= (length ?? 0)
            ? (text.substring(0, length) + ((length ?? 0) > 0 ? ".." : ""))
            : text,
        minFontSize: 5,
        textAlign: textAlign,
        maxLines: maxLines,
        style: TextStyle(
            fontFamily: textFonts,
            fontSize: 15,
            color: color ??
                (modeControll.ThemeModeValue ? Colors.black54 : Colors.white54),
            fontWeight: FontWeight.bold),
      );

  static Textsub(
          {required String text, Color? color, double? size, int? maxLines}) =>
      AutoSizeText(
        text,
        minFontSize: 5,
        maxLines: maxLines,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontFamily: textFonts,
          fontSize: size ?? 14,
          color: color ??
              (modeControll.ThemeModeValue ? Colors.black45 : Colors.white38),
        ),
      );

  static Textspcfic(
          {required String text,
          int? maxLines,
          Color? color,
          double? size,
          FontWeight? fontWeight}) =>
      AutoSizeText(
        text,
        maxLines: maxLines,
        minFontSize: 5,
        style: TextStyle(
          fontWeight: fontWeight,
          fontFamily: textFonts,
          fontSize: size ?? 13,
          color: color,
        ),
      );

  static SpanText(
      {required String FirstText,
      required bool chick,
      required String SecntText,
      double? size}) {
    if (chick) {
      return Row(
        children: [
          Expanded(
            child: AutoSizeText(FirstText,
                textAlign: TextAlign.end,
                minFontSize: 5,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: textFonts,
                  fontSize: size ?? 13,
                  color: (modeControll.ThemeModeValue
                      ? Colors.black
                      : Colors.white),
                )),
          ),
          const AutoSizeText(" "),
          Expanded(
            child: AutoSizeText(SecntText,
                minFontSize: 5,
                textAlign: TextAlign.start,
                style: TextStyle(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: Colors.red,
                    decorationThickness: 2,
                    fontWeight: FontWeight.bold,
                    fontFamily: textFonts,
                    fontSize: size ?? 13,
                    color: Colors.red)),
          ),
        ],
      );
    } else {
      return AutoSizeText(FirstText,
          minFontSize: 5,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: textFonts,
            fontSize: size ?? 13,
            color: (modeControll.ThemeModeValue ? Colors.black : Colors.white),
          ));
    }
  }

  static SpanSpcficText(
          {required String FirstText,
          required String SecntText,
          Color? SecntColor}) =>
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: FirstText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: textFonts,
                  fontSize: 13,
                  color: (modeControll.ThemeModeValue
                      ? Colors.black54
                      : Colors.white54),
                )),
            TextSpan(
                text: " : ",
                style: TextStyle(
                  fontSize: 11,
                  color: (modeControll.ThemeModeValue
                      ? Colors.black
                      : Colors.white),
                )),
            TextSpan(
                text: SecntText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: textFonts,
                  fontSize: 15,
                  color: SecntColor ??
                      (modeControll.ThemeModeValue
                          ? Colors.black54
                          : Colors.white54),
                )),
          ],
        ),
      );
  static SpcficText({
    required String FirstText,
    required String SecntText,
    required bool chick,
  }) =>
      RichText(
        text: TextSpan(
          children: [
            TextSpan(
                text: FirstText,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: textFonts,
                  fontSize: 14,
                  color: (modeControll.ThemeModeValue
                      ? Colors.black54
                      : Colors.white54),
                )),
            TextSpan(
                text: " ",
                style: TextStyle(
                  fontSize: 14,
                  color: (modeControll.ThemeModeValue
                      ? Colors.black
                      : Colors.white),
                )),
            if (chick)
              TextSpan(
                  text: SecntText,
                  style: const TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationColor: Colors.red,
                      decorationThickness: 2,
                      fontWeight: FontWeight.bold,
                      fontFamily: textFonts,
                      fontSize: 14,
                      color: Colors.red)),
          ],
        ),
      );
}
