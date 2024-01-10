import 'package:client_swift/Controll/menuControll.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';
import 'package:client_swift/Widgets/DrawerItem.dart';
import 'package:client_swift/Widgets/TextUnit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SideMenu extends StatefulWidget {
  bool isMobile;
  Function update;
  SideMenu({super.key, required this.isMobile, required this.update});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MenuControll>(
        init: MenuControll(),
        builder: (controll) {
          return Drawer(
            elevation: 3,
            backgroundColor:
                classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
            surfaceTintColor:
                classColors.NEUTRAL(modeControll.ThemeModeValue)[4],
            shape: const BorderDirectional(),
            child: SafeArea(
              child: ListView(
                children: [
                  const SizedBox(
                    height: 7,
                  ),
                  const DrawerHeader(
                    child: FlutterLogo(
                      size: 31,
                    ),
                  ),
                  DrawerItem(
                    title: language[modeControll.LanguageValue]["titelOrder"],
                    svgSrc: "assets/icons/menu_dashboard.svg",
                    press: () {
                      pageController.animateToPage(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                      if (widget.isMobile) {
                        controll.closeMenu();
                      }
                    },
                  ),
                  DrawerItem(
                    title: language[modeControll.LanguageValue]["static"],
                    svgSrc: "assets/icons/menu_tran.svg",
                    press: () {
                      pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                      if (widget.isMobile) {
                        controll.closeMenu();
                      }
                    },
                  ),
                  DrawerItem(
                    title: language[modeControll.LanguageValue]["receipt"],
                    svgSrc: "assets/icons/menu_doc.svg",
                    press: () {
                      pageController.animateToPage(2,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                      if (widget.isMobile) {
                        controll.closeMenu();
                      }
                    },
                  ),
                  DrawerItem(
                    title: language[modeControll.LanguageValue]["notification"],
                    svgSrc: "assets/icons/menu_notification.svg",
                    press: () {
                      pageController.animateToPage(3,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                      if (widget.isMobile) {
                        controll.closeMenu();
                      }
                    },
                  ),
                  DrawerItem(
                    title: language[modeControll.LanguageValue]["users"],
                    svgSrc: "assets/icons/menu_profile.svg",
                    press: () {
                      pageController.animateToPage(4,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn);
                      if (widget.isMobile) {
                        controll.closeMenu();
                      }
                    },
                  ),
                  const Divider(),
                  ListTile(
                    onTap: () {
                      modeControll.languageToggle();

                      setState(() {});
                      widget.update();
                    },
                    horizontalTitleGap: 0.0,
                    leading: Icon(
                      Icons.language,
                      color: modeControll.ThemeModeValue
                          ? Colors.black45
                          : Colors.white54,
                    ),
                    title: TextUnit.TextsubTitel(
                        text: modeControll.LanguageValue ? "English" : "عربي"),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ],
              ),
            ),
          );
        });
  }
}
