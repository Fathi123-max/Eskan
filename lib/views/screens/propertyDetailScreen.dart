import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/used/currentUserInfoController.dart';
import 'package:haider/models/used/propertyModel.dart';
import 'package:haider/utills/customColors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../controllers/unused/usrechatcontroller.dart';
import '../../controllers/used/rentAndRentOutController.dart';
import '../chat/chats.dart';

class PropertyDetailScreen extends StatelessWidget {
  final PropertyModel property;

  PropertyDetailScreen({required this.property});
  var firebaseuser = FirebaseAuth.instance.currentUser;
  final CurrentUserInfoController controller =
      Get.put(CurrentUserInfoController());

  final userchatController chasusercontroller = Get.put(userchatController());
  // final SqfliliteController sqfliliteController =
  //     Get.put(SqfliliteController());

  launchWhatsApp() async {
    try {
      print(property.usernumber);
      print("***********************************");
      final link =
          WhatsAppUnilink(phoneNumber: "+2${property.usernumber}", text: "");
      await launch('$link');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RentAndRentOutController()).username.value = property.username!;

    return Scaffold(
        bottomSheet: Container(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () =>
                      FlutterPhoneDirectCaller.callNumber(property.usernumber!),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      ),
                      color: CustomColors.green_color,
                    ),
                    child: Center(
                        child: Icon(
                      Icons.call,
                      color: Colors.white,
                    )),
                  ),
                ),
              ),
              Expanded(
                  child: InkWell(
                onTap: () => launchWhatsApp(),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                      color: Colors.green),
                  child: Center(
                    child: FaIcon(
                      color: Colors.white,
                      FontAwesomeIcons.whatsapp,
                      size: 30,
                    ),
                  ),
                ),
              ))
            ],
          ),
        ),
        appBar: AppBar(
          centerTitle: true,
          title: Text(property.address!),
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () => Get.back(),
                icon: Icon(Icons.arrow_back_ios_new)),
          ],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 220,
                  child: Stack(
                    children: [
                      PageView(
                        onPageChanged: (index) {
                          controller.selectedIndex.value = index;
                        },
                        scrollDirection: Axis.horizontal,
                        children: property.images!.map((e) {
                          return ViewPhoto(e, property);
                        }).toList(),
                      ),
                      Obx(() {
                        return Align(
                          alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: property.images!.map((e) {
                              int index = property.images!.indexOf(e);
                              return Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color:
                                        controller.selectedIndex.value == index
                                            ? CustomColors.prime_color
                                            : Colors.black54,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ],
                  ),
                ),

                // price
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${property.price} جنيه',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: CustomColors.prime_color),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  '${property.city![0].toUpperCase()}${property.city!.substring(1).toLowerCase()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                //name
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    property.address!,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 20),
                  ),
                ),

                //descrip
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'Description'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    property.descr ?? "",
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),

                //adress
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'address'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    property.area!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'نوع العقار'.tr,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    property.propertyType!,
                    textAlign: TextAlign.justify,
                    style: TextStyle(color: Colors.black54),
                  ),
                ),
                // addtional informations
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Text(
                    'معلومات اضافيه ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.bed_outlined),
                      Text(
                        ' ${property.bedrooms} غرف نوم ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.bathtub_outlined),
                      Text(
                        ' ${property.bathrooms} حمام',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.kitchen_outlined),
                      Text(
                        ' ${property.kitchen} مطبخ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.crop_square_outlined),
                      Text(
                        ' ${property.size} متر',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    children: [
                      Icon(Icons.chair_outlined),
                      Text(
                        ' ${property.propertyFor} صاله',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      )
                    ],
                  ),
                ),

                //service provider
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10, right: 15),
                  child: Text(
                    'Service Provider'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.prime_color,
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.isLoading.value == true) {
                    return CircularProgressIndicator();
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 15, top: 10, right: 15, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(firebaseuser!.photoURL!),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    property.username!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Text(property.usernumber!),
                            ],
                          ),
                          Container(
                            width: 100,
                          )
                        ],
                      ),
                    );
                  }
                }),
                SizedBox(
                  height: 25,
                )
              ],
            ),
          ),
        ));
  }

  void _handlePressed(types.User otherUser) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    Get.to(
      () => ChatPage(
        room: room,
      ),
    );
  }
}

class ViewPhoto extends GetView {
  ViewPhoto(this.e, this.property);
  var e;
  PropertyModel property;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: e,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.black,
                  centerTitle: true,
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        icon: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                        )),
                  ],
                  elevation: 0.0,
                ),
                backgroundColor: Colors.black,
                body: PhotoView(
                  imageProvider: NetworkImage(e),
                  backgroundDecoration: BoxDecoration(color: Colors.black),
                  loadingBuilder: (context, event) =>
                      Center(child: CircularProgressIndicator()),
                ),
              ),
            ),
          );
        },
        child: CachedNetworkImage(
          imageUrl: e,
          imageBuilder: (context, imageProvider) => Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          placeholder: (context, url) =>
              Center(child: CircularProgressIndicator()),
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}
