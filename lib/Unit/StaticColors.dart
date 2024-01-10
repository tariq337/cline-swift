import 'dart:ui';

import 'package:client_swift/Unit/classColors.dart';
import 'package:client_swift/Unit/const.dart';

Color StaticColors(int s) {
  switch (s) {
    case 0:
      return classColors.STATICS(modeControll.ThemeModeValue)[4];
    case 1:
      return classColors.STATICS(modeControll.ThemeModeValue)[0];
    case 2:
      return classColors.STATICS(modeControll.ThemeModeValue)[0];
    case 3:
      return classColors.STATICS(modeControll.ThemeModeValue)[1];
    case 4:
      return classColors.STATICS(modeControll.ThemeModeValue)[2];
    case 5:
      return classColors.STATICS(modeControll.ThemeModeValue)[3];

    default:
      return classColors.STATICS(modeControll.ThemeModeValue)[4];
  }
}
