import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class userchatController extends GetxController {
  RxList<types.User> userchatlist = RxList<types.User>([]);

  @override
  void onInit() async {
    await getAllusers();

    super.onInit();
  }

  Future<String> getAllusers() async {
    FirebaseChatCore.instance.users().listen((event) {
      print(event.length);
      print("***************************************");
      userchatlist.value = event;
    });
    return "";
  }
}
