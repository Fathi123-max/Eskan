import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'add_information.dart';

class GoogleLoginScreen extends StatefulWidget {
  @override
  _GoogleLoginScreenState createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen>
    with SingleTickerProviderStateMixin {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  AnimationController? _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    )..repeat();
  }

  void _handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      // Handle successful sign-in here
      Get.off(() => EnterInfo()); // Replace with your home screen route
    } catch (error) {
      // Handle sign-in error here
      print(error);
    }
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: _animationController!,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.blue.withOpacity(_animationController!.value),
                      Colors.white.withOpacity(_animationController!.value),
                    ],
                  ),
                ),
              );
            },
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/search.png', // Replace with your Google logo asset
                  height: 120,
                  width: 120,
                ),
                SizedBox(height: 30),
                Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () => _handleSignIn(context),
                  icon: Icon(Icons.login),
                  label: Text('Sign In'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
