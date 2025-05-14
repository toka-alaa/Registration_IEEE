import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:registration_ieee/views/layout.dart';
import 'package:registration_ieee/views/logo_page.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      checkOnboarding(context);
    });
  }


  void checkOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

    if (seenOnboarding) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Layout()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LogoPage()));
    }
  }


  @override
  Widget build(BuildContext c) {
    return  Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Animate(
                effects: [
                  FadeEffect(),
                  ScaleEffect(),
                  RotateEffect(),
                ],
                child: Image.asset(
                  'assets/qr.png',
                width: 230,
                  height: 230,
                ),
              ),
              
              const SizedBox(height: 50),
              
              Animate(
                effects: [
                  FadeEffect(),
                  ScaleEffect(),
                  RotateEffect(),
                ],
                child: Text("Event Registration",
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
