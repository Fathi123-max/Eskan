import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeController extends GetxController {
  final _isDarkTheme = false.obs;

  bool get isDarkTheme => _isDarkTheme.value;

  void toggleTheme() {
    _isDarkTheme.value = !_isDarkTheme.value;
    GetStorage().write('isDarkTheme', _isDarkTheme.value);
  }
}
