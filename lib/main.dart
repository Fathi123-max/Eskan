import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/views/used/choosescreen.dart';
import 'package:haider/views/used/homeView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,

    statusBarColor: Colors.white, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var box;

  @override
  void initState() {
    super.initState();
    box = GetStorage().read('name');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: const Locale('ar', 'EG'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        secondaryHeaderColor: CustomColors.coral_Color,
        primaryColor: CustomColors.prime_color,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        brightness: Brightness.light,
        useMaterial3: true,
      ),
      home: box == null ? EnterInfo() : Home(),
    );
  }
}
//7C:7A:B1:72:A1:2E:6D:DF:0E:C1:E8:7F:63:78:3E:E5:23:7C:52:4A
//BC:87:6C:AF:78:1C:3C:D6:35:8E:BA:71:0E:3C:96:AB:66:62:9D:4F:0B:86:8E:C7:3D:54:C8:52:73:68:69:C7
