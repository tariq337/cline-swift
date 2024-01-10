import 'package:client_swift/Controll/ModeControll.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

PageController pageController = PageController(initialPage: 0);

PageController pageOrderController = PageController(initialPage: 0);
PageController pageOrderStateController = PageController(initialPage: 0);
PageController pageFormController = PageController(initialPage: 0);

PageController pageProfileController = PageController(initialPage: 0);

PageController pageUsrtController = PageController(initialPage: 0);

final modeControll = Get.find<ModeControll>();
