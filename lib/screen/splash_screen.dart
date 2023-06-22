import 'package:flutter/material.dart';
import 'package:onicame/main.dart';
import 'package:onicame/screen/signin_screen.dart';
import 'package:onicame/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2));
    if (box.read("login") == true) {
      Navigator.pushNamed(context, "/dashboard");
    } else {
      push(const LoginScreen(),
          pageRouteAnimation: PageRouteAnimation.Fade, isNewTask: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(appImages.appIcon, fit: BoxFit.cover, height: 170),
              Text(appName, style: boldTextStyle(size: 22)),
            ],
          ).center(),
        ],
      ),
    );
  }
}
