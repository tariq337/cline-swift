import 'package:client_swift/Unit/const.dart';
import 'package:client_swift/Unit/language.dart';

String StaticName(int s) {
  switch (s) {
    case 0:
      return language[modeControll.LanguageValue]["staticOrders"][0];
    case 1:
      return language[modeControll.LanguageValue]["staticOrders"][1];
    case 2:
      return language[modeControll.LanguageValue]["staticOrders"][2];
    case 3:
      return language[modeControll.LanguageValue]["staticOrders"][3];
    case 4:
      return language[modeControll.LanguageValue]["staticOrders"][4];
    case 5:
      return language[modeControll.LanguageValue]["staticOrders"][5];

    default:
      return language[modeControll.LanguageValue]["staticOrders"][0];
  }
}
