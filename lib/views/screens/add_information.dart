import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/used/currentUserInfoController.dart';
import '../../utills/customColors.dart';
import 'homeView.dart';

class EnterInfo extends StatefulWidget {
  @override
  State<EnterInfo> createState() => _EnterInfoState();
}

class _EnterInfoState extends State<EnterInfo> {
  final box = GetStorage();

  final controller = Get.put(CurrentUserInfoController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/logo.gif'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "أدخل بياناتك ",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  cursorColor: CustomColors.prime_color,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.prime_color),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.prime_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.prime_color),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.prime_color),
                    ),
                    labelText: 'Name'.tr,
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      FontAwesomeIcons.person,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null) ;
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  cursorColor: CustomColors.prime_color,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.prime_color),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.prime_color),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.prime_color),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.prime_color),
                    ),
                    labelText: 'Phone'.tr,
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      FontAwesomeIcons.phone,
                      color: Colors.grey,
                    ),
                  ),
                  validator: (value) {
                    if (value == '' || value == null) ;
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                child: InkWell(
                  onTap: _isButtonEnabled
                      ? () async {
                          box.write('name', _nameController.text);
                          box.write('phone', _phoneController.text);

                          Get.offAll(() => Home());
                          // Get.offAll(() => GoogleLoginScreen());
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? CustomColors.green_color
                          : Colors.grey,
                      border: Border.all(color: CustomColors.green_color),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'الى الشاشه الرئيسيه'.tr,
                        style: TextStyle(color: CustomColors.secondary_color),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _nameController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isButtonEnabled = _formKey.currentState?.validate() ?? false;
    });
  }
}
