import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_manag_provider/provider/splash_screen_provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
     Provider.of<SplashProvider>(context, listen: false).goToLogin(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Image.asset(
              
              'assets/organisation.png',
              width: 130,
              height: 130,
            ),
          ),
        ),
      ),
    );
  }
}