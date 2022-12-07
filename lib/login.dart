// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:singkawang/main_menu.dart';
import 'package:singkawang/register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 21.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.09,
                ),
                //logo section
                logo(size.height / 7, size.height / 7),
                SizedBox(
                  height: size.height * 0.03,
                ),
                headerText(),
                SizedBox(
                  height: size.height * 0.04,
                ),
                //email & password section
                emailTextField(size),
                SizedBox(
                  height: size.height * 0.04,
                ),
                passwordTextField(size),
                SizedBox(
                  height: size.height * 0.04,
                ),

                //sign in button & sign in with text
                signInButton(size),
                SizedBox(
                  height: size.height * 0.02,
                ),
                signInWithText(),
                SizedBox(
                  height: size.height * 0.02,
                ),

                // //sign in with google & apple
                // // signInGoogleButton(size),
                SignInOneSocialButton(
                  iconPath: 'assets/google_logo.svg',
                  text: 'Masuk Dengan Google',
                  size: size,
                ),
                SizedBox(
                  height: size.height * 0.0,
                ),
                // signInAppleButton(size),
                SizedBox(
                  height: size.height * 0.03,
                ),
                //sign up text here
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  footerText(),
                  TextButton(
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        color: Color(0xFF21899C),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text('Daftar',
                        style: TextStyle(
                            color: Color(0xFF21899C), fontSize: 14.0)),
                  ),
                ]),
                SizedBox(
                  height: size.height * 0.03,
                ),
                loginText(),
                SizedBox(
                  height: size.height * 0.03,
                ),
              ],
            ),
          ),
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

  Widget emailTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 14,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFF21899C),
        ),
      ),
      child: TextField(
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF15224F),
        ),
        maxLines: 1,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
            labelText: 'Alamat Email',
            labelStyle: GoogleFonts.inter(
              fontSize: 12.0,
              color: const Color(0xFF969AA8),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return Container(
      alignment: Alignment.center,
      height: size.height / 14,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFF21899C),
        ),
      ),
      child: TextField(
        style: GoogleFonts.inter(
          fontSize: 16.0,
          color: const Color(0xFF15224F),
        ),
        maxLines: 1,
        obscureText: true,
        keyboardType: TextInputType.visiblePassword,
        cursorColor: const Color(0xFF15224F),
        decoration: InputDecoration(
            labelText: 'Kata Sandi',
            labelStyle: GoogleFonts.inter(
              fontSize: 12.0,
              color: const Color(0xFF969AA8),
            ),
            border: InputBorder.none),
      ),
    );
  }

  Widget signInButton(Size size) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MainMenu(),
          ),
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: size.height / 14,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: const Color(0xFF21899C),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4C2E84).withOpacity(0.2),
              offset: const Offset(0, 15.0),
              blurRadius: 60.0,
            ),
          ],
        ),
        child: Text(
          'Masuk',
          style: GoogleFonts.inter(
            fontSize: 16.0,
            color: Colors.white,
            fontWeight: FontWeight.w600,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget signInWithText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(child: Divider()),
        const SizedBox(
          width: 16,
        ),
        Text(
          'atau gunakan akun',
          style: GoogleFonts.inter(
            fontSize: 12.0,
            color: const Color(0xFF969AA8),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          width: 16,
        ),
        const Expanded(child: Divider()),
      ],
    );
  }

  Widget headerText() {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: 13.0,
          color: const Color(0xFF3B4C68),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text: 'Silahkan Masuk Untuk Melanjutkan',
          ),
        ],
      ),
    );
  }

  Widget loginText() {
    return Text.rich(
      textAlign: TextAlign.center,
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF3B4C68),
          fontWeight: FontWeight.w500,
        ),
        children: const [
          TextSpan(
            text:
                'Dengan masuk ke aplikasi SI-AGEN, saya menyetujui segala Syarat dan Ketentuan SI-AGEN',
          ),
        ],
      ),
    );
  }

  //sign up text here
  Widget footerText() {
    return Text.rich(
      TextSpan(
        style: GoogleFonts.inter(
          fontSize: 12.0,
          color: const Color(0xFF3B4C68),
        ),
        children: const [
          TextSpan(
            text: 'Belum punya akun?',
          ),
        ],
      ),
    );
  }
}

class SignInOneSocialButton extends StatelessWidget {
  SignInOneSocialButton(
      {Key? key,
      required this.size,
      required this.iconPath,
      required this.text})
      : super(key: key);
  Size size;
  String iconPath;
  String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height / 14,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40.0),
        border: Border.all(
          width: 1.0,
          color: const Color(0xFF134140),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            flex: 1,
            child: SvgPicture.asset(iconPath),
          ),
          Expanded(
            flex: 2,
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 15.0,
                color: const Color(0xFF134140),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
