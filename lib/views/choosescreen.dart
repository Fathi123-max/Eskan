import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haider/views/drawerViews/homeView.dart';

import '../controllers/currentUserInfoController.dart';
import '../utills/customColors.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<void> _signInWithGoogle() async {
  try {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser == null) {
      // User cancelled the sign-in
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with Firebase Authentication
    final userCredential = await _auth.signInWithCredential(credential);

    // Get the UID of the authenticated user.
    final uid = userCredential.user!.uid;
    await FirebaseChatCore.instance.createUserInFirestore(
      types.User(
        firstName: googleUser.displayName,
        id: uid,
        imageUrl:
            'https://images.unsplash.com/photo-1572635196237-14b3f281503f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8cHJvZHVjdHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60',
        lastName: googleUser.displayName,
      ),
    );
/**
  void _register() async {
    FocusScope.of(context).unfocus();

    setState(() {
      _registering = true;
    });

    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _usernameController!.text,
        password: _passwordController!.text,
      );
      await FirebaseChatCore.instance.createUserInFirestore(
        types.User(
          firstName: _firstName,
          id: credential.user!.uid,
          imageUrl: 'https://i.pravatar.cc/300?u=$_email',
          lastName: _lastName,
        ),
      );

      if (!mounted) return;
      Navigator.of(context)
        ..pop()
        ..pop();
    } catch (e) {
      setState(() {
        _registering = false;
      });

      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
          content: Text(
            e.toString(),
          ),
          title: const Text('Error'),
        ),
      );
    }
  }
 */
    // Navigate to the home screen
    Get.offAll(() => Home());
  } catch (e) {
    // Handle sign-in errors
    print('Error signing in with Google: $e');
  }
}

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
                      image: AssetImage('assets/images/logo.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Enter your information",
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
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    labelText: 'Name'.tr,
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.email_outlined,
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
                  cursorColor: CustomColors.orangeColor,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: CustomColors.orangeColor),
                    ),
                    labelText: 'Phone'.tr,
                    labelStyle: TextStyle(color: Colors.grey),
                    prefixIcon: Icon(
                      Icons.email_outlined,
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
                          await _signInWithGoogle();
                          Get.offAll(() => Home());
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? CustomColors.lioghtGrey
                          : Colors.grey,
                      border: Border.all(color: CustomColors.lioghtGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Next'.tr,
                        style: TextStyle(color: CustomColors.greyColor),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8, left: 25, right: 25),
                child: InkWell(
                  onTap: _isButtonEnabled
                      ? () async {
                          await _signInWithGoogle();
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      color: _isButtonEnabled
                          ? CustomColors.lioghtGrey
                          : Colors.grey,
                      border: Border.all(color: CustomColors.lioghtGrey),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 60,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Text(
                        'Sign in with google'.tr,
                        style: TextStyle(color: CustomColors.greyColor),
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
