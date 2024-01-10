import 'dart:developer';

import 'package:client_swift/UI/Body/body.dart';
import 'package:client_swift/UI/NavigationBar.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/UI/SideMenu.dart';
import 'package:client_swift/Unit/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    log("message");
    return Obx(() {
      return Directionality(
        textDirection:
            modeControll.LanguageValue ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          key: scaffoldKey,
          backgroundColor: classColors.NEUTRAL(modeControll.ThemeModeValue)[2],
          drawer: SideMenu(
            update: () {
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const Home()),
                  (Route<dynamic> route) => false);
            },
            isMobile: true,
          ),
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (Responsive.isDesktop(context))
                  Expanded(
                    child: SideMenu(
                      update: () {
                        setState(() {});
                      },
                      isMobile: false,
                    ),
                  ),
                const Expanded(
                  flex: 5,
                  child: Body(),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
