import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/currentUserInfoController.dart';
import 'package:haider/models/propertyModel.dart';
import 'package:haider/utills/customColors.dart';
import 'package:photo_view/photo_view.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../controllers/rentAndRentOutController.dart';
import '../controllers/usrechatcontroller.dart';
import 'chat/chats.dart';
import 'chat/users.dart';

class PropertyDetail extends StatelessWidget {
  final PropertyModel data;

  PropertyDetail({required this.data});

  final CurrentUserInfoController controller =
      Get.put(CurrentUserInfoController());

  final userchatController chasusercontroller = Get.put(userchatController());
  // final SqfliliteController sqfliliteController =
  //     Get.put(SqfliliteController());

  launchWhatsApp() async {
    try {
      print(data.usernumber);
      print("***********************************");
      final link =
          WhatsAppUnilink(phoneNumber: "+2${data.usernumber}", text: "");
      await launch('$link');
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(RentAndRentOutController()).username.value = data.username;
    // sqfliliteController.getLIkiedOnly(data.docId);
    return Scaffold(
        appBar: AppBar(
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
                        children: data.images.map((e) {
                          return Hero(
                            tag: e,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Scaffold(
                                      backgroundColor: Colors.black,
                                      body: PhotoView(
                                        imageProvider: NetworkImage(e),
                                        backgroundDecoration:
                                            BoxDecoration(color: Colors.black),
                                        loadingBuilder: (context, event) =>
                                            Center(
                                                child:
                                                    CircularProgressIndicator()),
                                      ),
                                    ),
                                  ),
                                );
                              },
                              child: CachedNetworkImage(
                                imageUrl: e,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
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
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: data.images.map((e) {
                      int index = data.images.indexOf(e);
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            color: controller.selectedIndex.value == index
                                ? CustomColors.orangeColor
                                : Colors.black54,
                            shape: BoxShape.circle,
                          ),
                        ),
                      );
                    }).toList(),
                  );
                }),
                // price
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${data.price} جنيه',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: CustomColors.orangeColor),
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
                                  '${data.city[0].toUpperCase()}${data.city.substring(1).toLowerCase()}',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54),
                                ),
                                Text(data.area),
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
                    data.address,
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
                    data.descr,
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
                    data.area,
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
                        ' ${data.bedrooms} غرف نوم ',
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
                        ' ${data.bathrooms} حمام',
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
                        ' ${data.kitchen} مطبخ',
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
                        ' ${data.size} متر',
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
                      color: CustomColors.orangeColor,
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data.username,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    ),
                                  ),
                                ],
                              ),
                              Text(data.usernumber),
                            ],
                          ),
                          IconButton(
                            onPressed: () => launchWhatsApp(),
                            icon: FaIcon(
                              color: Colors.green,
                              FontAwesomeIcons.whatsapp,
                              size: 30,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              print(data.usernumber);
                              print("***********************************");
                              FlutterPhoneDirectCaller.callNumber(
                                  data.usernumber);
                            },
                            icon: Icon(Icons.phone),
                          ),
                        ],
                      ),
                    );
                  }
                }),

                SizedBox(height: 100, child: UsersPage())
              ],
            ),
          ),
        ));
  }

/**ListTile(
                          title: Text(chasusercontroller
                              .userchatlist[index].firstName!),
                          leading: IconButton(
                            onPressed: () => _handlePressed(
                                chasusercontroller.userchatlist[index]),
                            icon: FaIcon(
                              color: Colors.green,
                              FontAwesomeIcons.whatsapp,
                              size: 30,
                            ),
                          ),
                        ), */
  void _handlePressed(types.User otherUser) async {
    final room = await FirebaseChatCore.instance.createRoom(otherUser);
    Get.to(
      () => ChatPage(
        room: room,
      ),
    );
  }
}
