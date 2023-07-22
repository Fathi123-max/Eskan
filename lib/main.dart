import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/models/used/timeadapter.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/views/used/choosescreen.dart';
import 'package:haider/views/used/homeView.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'models/used/propertyModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Hive.initFlutter();
  Hive.registerAdapter(TimestampAdapter());
  Hive.registerAdapter(PropertyModelAdapter());
  await Hive.openBox<PropertyModel>(
      'favorites'); // Open a box to store favorite PropertyModel objects.
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);

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
