import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../controllers/used/currentUserInfoController.dart';
import '../../utills/customColors.dart';
import '../screens/addDataScreen.dart';

class EnterInfoDialog extends StatefulWidget {
  @override
  State<EnterInfoDialog> createState() => _EnterInfoDialogState();
}

class _EnterInfoDialogState extends State<EnterInfoDialog> {
  // ... Same code as before ...
  final box = GetStorage();

  final controller = Get.put(CurrentUserInfoController());

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  bool _isButtonEnabled = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // ... Existing code ...
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
              //   child: Container(
              //     height: 300,
              //     width: 300,
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: AssetImage('assets/images/icon.png'),
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   ),
              // ),
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
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: _validateName,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 25, right: 25, top: 8, bottom: 2),
                child: TextFormField(
                  // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  validator: _validatePhone,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                child: InkWell(
                  onTap: _isButtonEnabled
                      ? () async {
                          box.write('name', _nameController.text);
                          box.write('phone', _phoneController.text);

                          // Close the dialog when the button is tapped
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                                  builder: (context) => AddDataScreen(
                                        value: '',
                                      )));

                          // Navigate to the Home view or any other view you desire.
                          // For example:
                          // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
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
                        'حفظ'.tr,
                        style: TextStyle(color: Colors.white),
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

  String? _validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null; // Return null when the input is valid.
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }

    // Remove any non-numeric characters from the input
    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Check if the numericValue has exactly 11 digits and starts with '01'
    if (numericValue.length != 10 || !numericValue.startsWith('01')) {
      return 'Please enter a valid phone number with 11 digits starting with 01';
    }

    return null; // Return null when the input is valid.
  }

  // ... Same code as before ...
}
