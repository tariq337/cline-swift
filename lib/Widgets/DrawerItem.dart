import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:client_swift/Unit/classColors.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(
            classColors.NEUTRAL(modeControll.ThemeModeValue)[0],
            BlendMode.srcIn),
        height: 21,
      ),
      title: TextUnit.TextsubTitel(text: title),
    );
  }
}
