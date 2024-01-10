import 'package:get/get.dart';
import 'package:client_swift/Unit/const.dart';

class MenuControll extends GetxController {
  void openMenu() {
    if (!scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.openDrawer();
    }
  }

  void closeMenu() {
    if (scaffoldKey.currentState!.isDrawerOpen) {
      scaffoldKey.currentState!.closeDrawer();
    }
  }
}
