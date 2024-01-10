import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ModeControll extends GetxController {
  RxBool islanguage = true.obs;
  GetStorage localDB = GetStorage();
  RxBool themeMode = true.obs;
  @override
  void onInit() {
    super.onInit();
    getdata();
  }

  getdata() {
    islanguage(!localDB.hasData("language"));
    themeMode(!localDB.hasData("theme"));
  }

  bool get ThemeModeValue => themeMode.value;

  bool get LanguageValue => islanguage.value;

  void languageToggle() {
    if (localDB.hasData("language")) {
      localDB.remove("language");
      islanguage(true);
    } else {
      localDB.write("language", "EN");

      islanguage(false);
    }
  }

  void themeToggle() {
    if (localDB.hasData("theme")) {
      localDB.remove("theme");
      themeMode(true);
    } else {
      localDB.write("theme", "dark");

      themeMode(false);
    }
  }
}
