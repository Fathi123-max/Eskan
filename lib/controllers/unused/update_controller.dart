import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:haider/models/updatemodel.dart';

class updateController extends GetxController {
  List<updateModel> updateList = [];

  @override
  void onInit() {
    getAllupdaetList();

    super.onInit();
  }

  Future<List<updateModel>> getAllupdaetList() async {
    await FirebaseFirestore.instance
        .collection('update')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        var updateMode =
            updateModel.fromMap(doc.data() as Map<String, dynamic>);

        updateList.add(updateMode);
      });
    });
    return updateList;
  }
}
