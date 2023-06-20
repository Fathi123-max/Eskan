// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:get/get.dart';

// import '../services/firestoreService.dart';

// class catogryController extends GetxController {
//   RxList<catogrumodel> catogryList = RxList<catogrumodel>([]);

//   @override
//   void onInit() {
//     super.onInit();
//     getAllupdaetList();
//   }

//   Future<List<catogrumodel>> getAllupdaetList() async {
//     await FirebaseFirestore.instance
//         .collection('catogry')
//         .get()
//         .then((QuerySnapshot querySnapshot) {
//       querySnapshot.docs.forEach((doc) {
//         print(doc.data());
//         print('*********************************');

//         var updateMode =
//             catogrumodel.fromMap(doc.data() as Map<String, dynamic>);

//         catogryList.add(updateMode);
//       });
//     });
//     print(catogryList);
//     return catogryList;
//   }

// }

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/catogrymodel.dart';
import '../services/firestoreService.dart';

class catogryController extends GetxController {
  RxList<User> catogryList = RxList<User>([]);

  @override
  void onInit() async {
    await getAllcatogryList();

    super.onInit();
  }

  Future<String> getAllcatogryList() async {
    await FirestoreService().getAllupdaetList().listen((event) {
      catogryList.value = event;
    });
    return "";
  }
}
