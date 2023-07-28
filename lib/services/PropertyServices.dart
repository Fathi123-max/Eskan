import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:haider/models/used/cityModel.dart';
import 'package:haider/models/used/propertyModel.dart';

import '../models/used/catogrymodel.dart';

class PropertyServices {
  final box = GetStorage();
  CollectionReference property =
      FirebaseFirestore.instance.collection('property');

//? add prop to  firebase
  Future<String> addproprtyToDatabase(
      PropertyModel propertyModel, List images, String typeFor) async {
    List imageUrls = [];
    propertyModel.images = images;
    propertyModel.currentUserId = "currentUser!.uid";

    propertyModel.propertyFor = typeFor;
    for (int i = 0; i < propertyModel.images!.length; i++) {
      //   var fileExtension = path.extension(propertyModel.images[i].path);
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      var firebaseStorageRef =
          FirebaseStorage.instance.ref().child('RealState/$fileName');
//quality  update
      await firebaseStorageRef
          .putData((await propertyModel.images![i].getByteData(quality: 5))
              .buffer
              .asUint8List())
          .then((result) {
        print('Uploaded');
      }).catchError((erorr) {
        print("Error in Uploading");
      });

      String url = await firebaseStorageRef.getDownloadURL();
      print(url);
      imageUrls.add(url);
    }
    String response = '';
    propertyModel.images = imageUrls;
    propertyModel.username = box.read('name');
    propertyModel.usernumber = box.read('phone');
    propertyModel.timestamp = Timestamp.now();

    await property.add(propertyModel.toMap()).then((value) {
      response = 'Data added';
    }).catchError((error) {
      response = 'error occured';
    });
    return response;
  }

//? get all data fun
  Stream<List<User>> getAllupdaetList() {
    return FirebaseFirestore.instance.collection('catogry').snapshots().map(
        (querySnapshot) =>
            querySnapshot.docs.map((doc) => User.fromMap(doc.data())).toList());
  }

  Stream<List<CityModel>> getAllcityList() {
    return FirebaseFirestore.instance.collection('city').snapshots().map(
        (querySnapshot) => querySnapshot.docs
            .map((doc) => CityModel.fromMap(doc.data()))
            .toList());
  }

  Future<List<PropertyModel>> getAllBuyingList() async {
    List<PropertyModel> propertyList = [];
    await FirebaseFirestore.instance
        .collection('property')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        PropertyModel propertyModel =
            PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
        if (doc['propertyFor'] == 'sale') {
          propertyList.add(propertyModel);
        }
      });
    });
    return propertyList;
  }

  firestorePagnation() {
    return property;
  }

  Future<List<PropertyModel>> getAllRentList() async {
    List<PropertyModel> propertyList = [];
    await FirebaseFirestore.instance
        .collection('property')
        .limit(10)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        PropertyModel propertyModel =
            PropertyModel.fromMap(doc.data() as Map<String, dynamic>);

        propertyList.add(propertyModel);
        print("**********************************");
        print(propertyModel);
        print("**********************************");
      });
    });
    return propertyList;
  }

  Future<List<PropertyModel>> getAllRentListByCatogry({String? search}) async {
    List<PropertyModel> propertyListbycat = [];
    await FirebaseFirestore.instance
        .collection('property')
        .where("propertyType", isEqualTo: search)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        PropertyModel propertyModel =
            PropertyModel.fromMap(doc.data() as Map<String, dynamic>);

        propertyListbycat.add(propertyModel);
      });
    });
    return propertyListbycat;
  }

//? operation fun
  Future<String> updateProperty(String docID, String updatedValue) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('property');
    String response = '';
    await collectionReference
        .doc(docID)
        .update({'propertyAction': updatedValue.toString()})
        .then((value) => response = 'Data Updated')
        .catchError((error) => response = "Failed to update user: $error");

    return response;
  }

  Future<String> deleteProperty(String docID, List images) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('property');
    String response = '';

    for (int i = 0; i < images.length; i++) {
      var storageReference =
          await FirebaseStorage.instance.refFromURL(images[i]);

      await storageReference.delete();

      print('image deleted');
    }
    await collectionReference
        .doc(docID)
        .delete()
        .then((value) => response = 'Property Deleted')
        .catchError((error) => response = "Failed to Delete Property: $error");

    return response;
  }

//? get current user fun
  Future<List<PropertyModel>> getCurrentUserPropertyForRentOut() async {
    // CustomToast.showToast(controller.currentUserId.value);
    List<PropertyModel> propertyList = [];
    await FirebaseFirestore.instance
        .collection('property')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        PropertyModel propertyModel =
            PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
        if (doc['username'] == box.read("name") &&
            doc['usernumber'] == box.read("phone")) {
          propertyList.add(propertyModel);
        }
      });
    });
    return propertyList;
  }

  Future<List<PropertyModel>> getCurrentUserPropertyForSelling() async {
    List<PropertyModel> propertyList = [];
    await FirebaseFirestore.instance
        .collection('property')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // print("Document Id is ${doc.id}");
        String docId = doc.id;
        PropertyModel propertyModel =
            PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
        // if (doc['currentUserId'] == controller.currentUserId.value &&
        //     doc['propertyFor'] == 'sale') {
        propertyList.add(propertyModel);
        // }
      });
    });
    return propertyList;
  }

//? Search fun

  Future<List<PropertyModel>> serachRentList(
      String cityname, String priceFrom, String priceTo) async {
    List<PropertyModel> propertyList = [];

    if (cityname != '' && priceFrom == '' && priceTo == '') {
      //   CustomToast.showToast('controller.cityEditTextController.text');
      await FirebaseFirestore.instance
          .collection('property')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];

          if (doc['propertyFor'] == 'rent' &&
              cityname.toLowerCase() == city.toLowerCase()) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom != '' && priceTo == '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price >= int.parse(priceFrom)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom == '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom != '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price >= int.parse(priceFrom) &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom != '' && priceTo == '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' && price >= int.parse(priceFrom)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom == '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);

          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' && price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom != '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'rent' &&
              price >= int.parse(priceFrom) &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    }

    return propertyList;
  }

  Future<List<PropertyModel>> serachBuyList(
      String cityname, String priceFrom, String priceTo) async {
    List<PropertyModel> propertyList = [];

    if (cityname != '' && priceFrom == '' && priceTo == '') {
      //   CustomToast.showToast('controller.cityEditTextController.text');
      await FirebaseFirestore.instance
          .collection('property')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];

          propertyList.add(propertyModel);
        });
      });
    } else if (cityname != '' && priceFrom != '' && priceTo == '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price >= int.parse(priceFrom)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom == '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname != '' && priceFrom != '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' &&
              cityname.toLowerCase() == city.toLowerCase() &&
              price >= int.parse(priceFrom) &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom != '' && priceTo == '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' && price >= int.parse(priceFrom)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom == '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);

          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' && price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    } else if (cityname == '' && priceFrom != '' && priceTo != '') {
      await FirebaseFirestore.instance
          .collection('property')
          .orderBy('price', descending: true)
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          PropertyModel propertyModel =
              PropertyModel.fromMap(doc.data() as Map<String, dynamic>);
          String city = doc['city'];
          int price = int.parse(doc['price']);
          if (doc['propertyFor'] == 'sale' &&
              price >= int.parse(priceFrom) &&
              price <= int.parse(priceTo)) {
            propertyList.add(propertyModel);
          }
        });
      });
    }

    return propertyList;
  }

/** "username": box.read('name'),
      "usernumber": box.read('phone'),
      'currentUserId': propertyModel.currentUserId.toString(),
      'propertyFor': propertyModel.propertyFor.toString(),
      'propertyType': propertyModel.propertyType.toString(),
      'city': propertyModel.city.toString(),
      'area': propertyModel.area.toString(),
      'size': propertyModel.size.toString(),
      'bedrooms': propertyModel.bedrooms.toString(),
      'address': propertyModel.address.toString(),
      'bathrooms': propertyModel.bathrooms.toString(),
      'kitchen': propertyModel.kitchen.toString(),
      'des': propertyModel.descr.toString(),
      'price': propertyModel.price.toString(),
      'images': imageUrls,
      'propertyAction': 'None'.toString(),
      'time': time */
}
