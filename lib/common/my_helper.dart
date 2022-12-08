// ignore_for_file: avoid_print, prefer_const_constructors

import 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../services/navigation_service.dart';
import '../widgets/custom_card.dart';
import 'my_color.dart';
import 'my_style.dart';

class MyHelper {
  static final formatDate = DateFormat("dd-MM-yyyy");
  static final formatTime = DateFormat("HH:mm");

  static String convertIndoToSqlDate(String date) {
    List<String> dateList = date.split('-');

    return dateList[2] + '-' + dateList[1] + '-' + dateList[0];
  }

  static bool isMapNull(var params) {
    for (var i = 0; i < params.length; i++) {
      if (params.values.elementAt(i) == '') {
        return true;
      }
    }

    return false;
  }

  static debounceSearch(void Function() action) async {
    EasyDebounce.debounce(
        'my-debouncer', // <-- An ID for this particular debouncer
        const Duration(milliseconds: 500), // <-- The debounce duration
        () => action() // <-- The target method
        );
  }

  static String formatIndoDate(String? date) {
    if (date == null || date == "" || date == "null") return "-";
    initializeDateFormatting('id_ID');
    final f =
        DateFormat("EEEE, dd MMM yyyy", "id_ID").format(DateTime.parse(date));
    return f.toString();
  }

  static String formatIndoTime(String? dateTime) {
    if (dateTime == null || dateTime == "" || dateTime == "null") return "-";
    initializeDateFormatting('id_ID');
    final f = DateFormat("HH:mm WIB", "id_ID").format(DateTime.parse(dateTime));
    return f.toString();
  }

  static String formatIndoDateTime(String? dateTime) {
    if (dateTime == null || dateTime == "" || dateTime == "null") return "-";
    initializeDateFormatting('id_ID');
    final f = DateFormat("EEEE, dd MMM yyyy HH:mm WIB", "id_ID")
        .format(DateTime.parse(dateTime));
    return f.toString();
  }

  static void toast(String message) {
    BotToast.showText(
      text: message,
      duration: const Duration(seconds: 5),
    );
  }

  static Future<void> setPref(String key, var value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);

    print("---> : set pref $value");
  }

  // static Future<void> setPrefBearerToken(var value) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(MyConst.bearerToken, 'Bearer ' + value);

  //   print("---> : set pref Bearer $value");
  // }

  static Future<dynamic> navPush(Widget widget) async {
    return await Navigator.push(NavigationService.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => widget));
  }

  static Future<dynamic> navPushReplacement(Widget widget) async {
    return await Navigator.pushReplacement(
        NavigationService.navigatorKey.currentContext!,
        MaterialPageRoute(builder: (context) => widget));
  }

  static Future<dynamic> navPop(dynamic value) async {
    return Navigator.pop(NavigationService.navigatorKey.currentContext!, value);
  }

  // --- How to use Future get pref : ---
  // MyHelper.getPref(MyConstanta.token).then((result){
  //  print("pref : " + result);
  //  write code here...
  // });
  static Future<String?> getPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("---> : get pref");

    return prefs.getString(key);
  }

  static deleteAllPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();

    print("---> : delete all pref");
  }

  static removeAnPref(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(key);

    print("---> : remove an pref");
  }

  static String formatRupiah(int? price) {
    if (price == 0 || price == null) {
      return "Rp 0";
    }

    final oCcy = NumberFormat("#,##0", "en_US");

    final f = oCcy.format(price);

    return "Rp " + f.toString().replaceAll(",", ".");
  }

  static void refreshState(GlobalKey? globalKey) {
    if (globalKey != null) {
      if (globalKey.currentState != null) {
        // ignore: invalid_use_of_protected_member
        globalKey.currentState!.setState(() {});
      }
    }
  }

  static launchURL(String? urlx) async {
    // ignore: unnecessary_null_comparison
    if (await canLaunchUrlString(urlx!) != null) {
      await launchUrlString(urlx);
    } else {
      MyHelper.toast("Could not launch $urlx");
      throw 'Could not launch $urlx';
    }
  }

  static launchURLExternalApp(String? urlx) async {
    // ignore: unnecessary_null_comparison
    if (await canLaunchUrlString(urlx!) != null) {
      await launchUrlString(
        urlx,
        mode: LaunchMode.externalApplication
      );
    } else {
      MyHelper.toast("Could not launch $urlx");
      throw 'Could not launch $urlx';
    }
  }

  static Future<dynamic> basicDialog({Widget? child}) async {
    return showDialog<void>(
      context: NavigationService.navigatorKey.currentContext!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.zero,
          content: child,
        );
      },
    );
  }

  static Future<dynamic> dialogOk(
      DialogType dialogType, String message, Function() action) {
    return AwesomeDialog(
      context: NavigationService.navigatorKey.currentContext!,
      dialogType: dialogType,
      animType: AnimType.BOTTOMSLIDE,
      title: 'Informasi',
      desc: message,
      btnOkOnPress: () => action(),
    ).show();
  }

  static Future<dynamic> dialogOkCancel(
      DialogType dialogType, String message, Function() action) {
    return AwesomeDialog(
            context: NavigationService.navigatorKey.currentContext!,
            dialogType: dialogType,
            animType: AnimType.BOTTOMSLIDE,
            title: 'Informasi',
            desc: message,
            btnOkOnPress: () => action(),
            btnCancelOnPress: () {})
        .show();
  }

  static printDebug(String text) {
    if (kDebugMode) {
      print("---> : $text");
    }
  }

  static Color colorRandom() {
    Random random = Random();
    return Color.fromARGB(
        255, random.nextInt(255), random.nextInt(255), random.nextInt(255));
  }

  static Future<XFile?> imagePicker() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image;

    await showModalBottomSheet<void>(
      context: NavigationService.navigatorKey.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return IntrinsicHeight(
          child: CustomCard(
            bgColor: MyColor.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Select image source',
                    style: MyStyle.textTitle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomCard(
                    onTap: () async {
                      image = await _picker.pickImage(
                        source: ImageSource.gallery,
                        maxHeight: 2000,
                        maxWidth: 2000,
                      );
                      MyHelper.navPop('');
                    },
                    borderRadius: BorderRadius.circular(100),
                    height: 50,
                    bgColor: MyColor.primary,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        'Gallery',
                        textAlign: TextAlign.center,
                        style:
                            MyStyle.textButton.copyWith(color: MyColor.white),
                      ),
                    ),
                  ),
                  CustomCard(
                    onTap: () async {
                      image = await _picker.pickImage(
                        source: ImageSource.camera,
                        maxHeight: 2000,
                        maxWidth: 2000,
                      );
                      MyHelper.navPop('');
                    },
                    borderRadius: BorderRadius.circular(100),
                    height: 50,
                    bgColor: MyColor.black,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Center(
                      child: Text(
                        'Camera',
                        textAlign: TextAlign.center,
                        style:
                            MyStyle.textButton.copyWith(color: MyColor.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    return image;
  }
}
