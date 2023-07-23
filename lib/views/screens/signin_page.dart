import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      duration: Duration(seconds: 5),
    )..repeat();
  }

  void _handleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      // Handle successful sign-in here
      Navigator.of(context)
          .pushReplacementNamed('/home'); // Replace with your home screen route
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
      appBar: AppBar(
        title: Text('Google Login'),
      ),
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
                      Colors.green.withOpacity(_animationController!.value),
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
                  'assets/google_logo.png', // Replace with your Google logo asset
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
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: FlutterSlider(
              values: [_animationController!.value],
              max: 1.0,
              min: 0.0,
              onDragCompleted: (handlerIndex, lowerValue, upperValue) {
                _animationController!.animateTo(lowerValue);
              },
              trackBar: FlutterSliderTrackBar(
                activeTrackBarHeight: 4,
                inactiveTrackBarHeight: 2,
                inactiveTrackBar: BoxDecoration(color: Colors.grey),
                activeTrackBar: BoxDecoration(color: Colors.white),
              ),
              handler: FlutterSliderHandler(
                decoration: BoxDecoration(),
                child: Material(
                  type: MaterialType.circle,
                  color: Colors.white,
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Icon(Icons.arrow_right),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
