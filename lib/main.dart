import 'package:client_swift/Controll/ModeControll.dart';
import 'package:client_swift/UI/Body/User/RegisterPage.dart';
import 'package:client_swift/Unit/const.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'UI/Home.dart';

void main() async {
  await GetStorage.init();
  Get.put(ModeControll());

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int index = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData();
  }

  _getData() async {
    GetStorage localDB = GetStorage();

    if (localDB.hasData("apiKey")) {
      setState(() {
        index = 2;
      });
    } else {
      setState(() {
        index = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.put(ModeControll());
      }),
      title: 'Demo',
      theme: modeControll.ThemeModeValue
          ? ThemeData(useMaterial3: true)
          : ThemeData.dark(useMaterial3: true),
      home: index == 0
          ? const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            )
          : index == 2
              ? const Home()
              : const RegisterPage(),
    );
  }
}
