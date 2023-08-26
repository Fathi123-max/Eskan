import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/utills/themes.dart';
import 'package:haider/views/screens/homeView.dart';

import 'controllers/used/favourateController.dart';
import 'controllers/used/themeControllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
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
    Get.put(FavoritesController());

    box = GetStorage().read('name');
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: Languages(),
        locale: const Locale('ar', 'EG'),
        debugShowCheckedModeBanner: false,
        title: 'إسكان',
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
        home: Home()

        //  FirebaseAuth.instance.currentUser == null
        //     ? GoogleLoginScreen()
        // : Home(),
        );
  }
}
