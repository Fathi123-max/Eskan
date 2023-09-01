import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/utills/themes.dart';
import 'package:haider/views/screens/homeView.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'controllers/used/favourateController.dart';
import 'controllers/used/themeControllers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: Colors.white, // status bar color
  ));
//Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize("0183cc36-fb23-4be7-89ed-d3b112693d01");

// The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);
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
