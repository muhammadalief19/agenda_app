import 'package:agenda_app/screen/note_list_page.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          Center(
            child: LottieBuilder.asset("assets/images/splash-screen.json"),
          )
        ],
      ),
      nextScreen: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF91B1E0),
              Color(0xFF003C73),
            ],
          ),
        ),
        child: const NoteListPage(),
      ),
      splashIconSize: 400,
      backgroundColor: Colors.white,
    );
  }
}
