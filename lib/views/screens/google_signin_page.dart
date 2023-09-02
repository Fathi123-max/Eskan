// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// // import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
// // import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:haider/views/screens/homeView.dart';

// class GoogleLoginScreen extends StatefulWidget {
//   @override
//   _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
// }

// class _GoogleLoginScreenState extends State<GoogleLoginScreen>
//     with SingleTickerProviderStateMixin {
//   bool signed = false;
//   Future<bool> _handleSignIn(BuildContext context) async {
//     try {
//       // Trigger the authentication flow
//       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication? googleAuth =
//           await googleUser?.authentication;

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken,
//         idToken: googleAuth?.idToken,
//       );

//       // Once signed in, return the UserCredential
//       // UserCredential userCredential =
//       //     await FirebaseAuth.instance.signInWithCredential(credential);

//       // await FirebaseChatCore.instance.createUserInFirestore(
//       //   types.User(
//       //     firstName: userCredential.user!.displayName,
//       //     id: userCredential.user!.uid, // UID from Firebase Authentication
//       //     imageUrl: userCredential.user!.photoURL,
//       //     lastName: "",
//       //   ),
//       // );

//       // Handle successful sign-in here
//       signed = true;
//       return true;
//       // Replace with your home screen route
//     } catch (error) {
//       print(error);
//       return false;
//       // Handle sign-in error here
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         foregroundColor: Color(0xFF4FC3F7),
//         backgroundColor: Color(0xFF4FC3F7),
//         systemOverlayStyle: SystemUiOverlayStyle(
//           statusBarIconBrightness: Brightness.light,
//           statusBarColor: Color(0xFF4FC3F7), // status bar color
//         ),
//       ),
//       body: Stack(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Color(0xFF4FC3F7), Color(0xFF039BE5)],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Image.asset(
//                   'assets/images/icon.png', // Replace with the path to your logo image
//                   height: 120,
//                 ),
//                 SizedBox(height: 20),
//                 Text(
//                   'أهلا بكم فى إسكان',
//                   style: TextStyle(
//                     fontSize: 32,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: 50),
//                 ElevatedButton(
//                   onPressed: () async {
//                     signed = await _handleSignIn(context);
//                     signed
//                         ? Get.offAll(
//                             () => Home(),
//                           )
//                         : Get.snackbar("خطأ ", "خطأ فى تسجيل الدخول",
//                             colorText: Colors.white,
//                             backgroundColor: Colors.red);
//                   },
//                   style: ElevatedButton.styleFrom(
//                     foregroundColor: Colors.black,
//                     backgroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(8),
//                     ),
//                     padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     elevation: 2,
//                   ),
//                   child: Row(
//                     mainAxisSize: MainAxisSize.min,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text(
//                         'سجل الدخول بجوجل',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w700),
//                       ),
//                       SizedBox(width: 12.0),
//                       Image.asset(
//                         'assets/search.png',
//                         height: 24.0,
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
