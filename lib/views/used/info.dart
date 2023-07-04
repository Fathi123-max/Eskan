import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:haider/controllers/update_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

class Info extends StatelessWidget {
  final controller = Get.put(updateController());

  @override
  Widget build(BuildContext context) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 50,
            ),
            Container(
              height: 300.0,
              width: 300,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 100.0),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(
                ' اذا وجدت اي مشاكل او مضايقات لا تردد في التواصل معنا',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () => launchWhatsApp(),
                  icon: FaIcon(
                    color: Colors.green,
                    FontAwesomeIcons.whatsapp,
                    size: 50,
                  ),
                )
              ],
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}

launchWhatsApp() async {
  try {
    final link = WhatsAppUnilink(phoneNumber: '+201024021764', text: "");
    await launch('$link');
  } catch (e) {
    print(e);
  }
}
