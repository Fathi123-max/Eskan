import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/utills/customColors.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/views/used/choosescreen.dart';
import 'package:haider/views/used/homeView.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'controllers/used/favourateController.dart';
import 'models/used/propertyModel.dart';
import 'models/used/timeadapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();
  await Hive.initFlutter();

  Hive.registerAdapter(TimestampAdapter());
  Hive.registerAdapter(PropertyModelAdapter());

  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocumentDirectory.path);

  // Check if the Hive box is already open
  if (!Hive.isBoxOpen('favorites')) {
    // Open the "favorites" box if it's not already open
    await Hive.openBox<PropertyModel>('favorites');
  }

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
    Get.put(FavoriteController());

    box = GetStorage().read('name');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: const Locale('ar', 'EG'),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      onInit: () => FavoriteController(),
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
