import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/utills/themes.dart';
import 'package:haider/views/screens/homeView.dart';
import 'package:haider/views/screens/signin_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import 'controllers/used/favourateController.dart';
import 'controllers/used/themeControllers.dart';
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
  ThemeController? themeController;

  @override
  void initState() {
    super.initState();
    themeController = Get.put(ThemeController());
    Get.put(FavoriteController());

    box = GetStorage().read('name');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      translations: Languages(),
      locale: const Locale('ar', 'EG'),
      debugShowCheckedModeBanner: false,
      title: 'إسكان',
      onInit: () => FavoriteController(),
      defaultTransition: Transition.cupertino,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: darkColorScheme,
      ),
      theme: ThemeData(
        colorScheme: lightColorScheme,
        useMaterial3: true,
      ),
      themeMode:
          themeController!.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      home: box == null ? GoogleLoginScreen() : Home(),
    );
  }
}
