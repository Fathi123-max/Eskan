import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/utills/localzation.dart';
import 'package:haider/utills/themes.dart';
import 'package:haider/views/screens/homeView.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'utills/app_config.dart';
import 'utills/app_bindings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    statusBarColor: Colors.transparent,
  ));

  // Remove this method to stop OneSignal Debugging
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);

  OneSignal.initialize(AppConfig.onesignalAppId);

  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt.
  // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  runApp(const MyApp());
}

/// Main application widget.
/// Uses GetX for state management and dependency injection.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize theme controller - it's registered as permanent in AppBindings
    final themeController = Get.find<ThemeController>();

    return GetMaterialApp(
      translations: Languages(),
      locale: const Locale('ar', 'EG'),
      defaultLocale: const Locale('ar', 'EG'),
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
      themeMode: themeController.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
      initialBinding: AppBindings(),
      home: const Home(),
    );
  }
}
