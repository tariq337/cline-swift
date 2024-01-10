import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';

class Messge {
  static error(String meg, context) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.redAccent,
          content: TextUnit.TextTitel(text: meg, color: Colors.white)));

  static notification(meg, context, {Color? color}) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: color ?? classColors.NEUTRAL(false)[4],
          content: TextUnit.TextTitel(text: meg, color: Colors.white)));
}
