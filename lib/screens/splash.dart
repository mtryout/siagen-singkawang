import 'dart:async';

import 'package:flutter/material.dart';
import 'package:singkawang/common/my_const.dart';
import 'package:singkawang/common/my_helper.dart';
import 'package:singkawang/screens/auth/login.dart';
import 'package:singkawang/screens/mainmenu/main_menu.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 2),
      () async {
        var bearer = await MyHelper.getPref(MyConst.bearer);
        if (bearer != null) {
          MyHelper.navPushReplacement(const MainMenu());
        } else {
          MyHelper.navPushReplacement(const LoginScreen());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            logo(170.0, 170.0),
          ],
        ),
      ),
    );
  }

  Widget logo(double height_, double width_) {
    return Image.asset(
      'assets/logo.png',
      height: height_,
      width: width_,
    );
  }
}
