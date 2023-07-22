import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/views/used/choosescreen.dart';
import 'package:haider/views/used/homeView.dart';
import 'package:hive_flutter/adapters.dart';

import 'models/used/propertyModel.dart';
import 'models/used/timeadapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Hive.initFlutter();

  Hive.registerAdapter(TimestampAdapter());
  Hive.registerAdapter(PropertyModelAdapter());

  // Open the "favorites" box before running the app

  await Hive.isBoxOpen('favorites') ? null : await Hive.openBox('favorites');

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
      defaultTransition: Transition.cupertino,
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
