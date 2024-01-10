import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Widgets/TextUnit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:client_swift/Controll/menuControll.dart';

class Header extends StatefulWidget {
  const Header({Key? key}) : super(key: key);

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: !Responsive.isDesktop(context)
          ? (classColors.NEUTRAL(modeControll.ThemeModeValue)[4])
          : null,
      child: Row(
        children: [
          if (Responsive.isTablet(context))
            GetBuilder<MenuControll>(
                init: MenuControll(),
                builder: (controll) {
                  return IconButton(
                    icon: const Icon(Icons.menu_rounded),
                    onPressed: () {
                      controll.openMenu();
                    },
                  );
                }),
          if (Responsive.isMobile(context))
            SizedBox(
              height: 50,
              width: 100,
              child: ListTile(
                onTap: () {
                  modeControll.languageToggle();

                  setState(() {});
                },
                horizontalTitleGap: 0.0,
                leading: const Icon(
                  Icons.language,
                  color: classColors.bgColor,
                ),
                title: TextUnit.TextsubTitel(
                    color: classColors.bgColor,
                    text: modeControll.LanguageValue ? "EN" : "AR"),
              ),
            ),
        ],
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 16),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16 / 2,
      ),
      decoration: BoxDecoration(
        color: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.perm_identity,
            size: 18,
          ),
          if (!Responsive.isMobile(context))
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16 / 2),
              child: Text("Angelina Jolie"),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(16 * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: 16 / 2),
            decoration: const BoxDecoration(
              color: classColors.bgColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
