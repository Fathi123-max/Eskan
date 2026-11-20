import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/controllers/used/themeControllers.dart';

void main() {
  setUp(() async {
    await GetStorage.init();
  });

  tearDown(() {
    Get.reset();
  });

  group('ThemeController', () {
    test('initial state is light theme', () {
      final controller = ThemeController();

      expect(controller.isDarkTheme, isFalse);
    });

    test('toggleTheme switches to dark', () {
      final controller = ThemeController();

      controller.toggleTheme();

      expect(controller.isDarkTheme, isTrue);
    });

    test('toggleTheme switches back to light', () {
      final controller = ThemeController();

      controller.toggleTheme();
      controller.toggleTheme();

      expect(controller.isDarkTheme, isFalse);
    });

    test('toggleTheme persists to storage', () {
      final controller = ThemeController();

      controller.toggleTheme();
      final storedValue = GetStorage().read('isDarkTheme');

      expect(storedValue, isTrue);
    });

    test('toggleTheme multiple times persists correctly', () {
      final controller = ThemeController();

      controller.toggleTheme();
      controller.toggleTheme();

      final storedValue = GetStorage().read('isDarkTheme');

      expect(storedValue, isFalse);
    });
  });
}
