import 'package:cloud_firestore/cloud_firestore.dart';
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "أدخل بياناتك لإضافة العقار",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: TextFormField(
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
                    labelText: 'الاسم',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      FontAwesomeIcons.person,
                      color: CustomColors.prime_color,
                    ),
                  ),
                  validator: _validateName,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: TextFormField(
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
                    labelText: 'رقم الهاتف',
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      FontAwesomeIcons.phone,
                      color: CustomColors.prime_color,
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
                          FirebaseFirestore.instance.collection("users").add({
                            "name": _nameController.text,
                            "phone": _phoneController.text
                          });
                          // Close the dialog when the button is tapped
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => AddDataScreen(
                                value: '',
                              ),
                            ),
                          );

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
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'حفظ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
      return 'من فضلك، أدخل اسمك';
    }
    return null; // Return null when the input is valid.
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'من فضلك، أدخل رقم هاتفك';
    }

    // Remove any non-numeric characters from the input
    final numericValue = value.replaceAll(RegExp(r'[^0-9]'), '');

    // Check if the numericValue has exactly 11 digits and starts with '01'
    if (numericValue.length != 10 || !numericValue.startsWith('01')) {
      return "يرجى إدخال رقم هاتف صحيح مكون من 11 رقمًا ويبدأ بـ 01";
    }

    return null; // Return null when the input is valid.
  }

  // ... Same code as before ...
}
