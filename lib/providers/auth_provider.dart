// import 'dart:convert';

// import 'package:warkahpintar/screens/peminjaman/main_menu_screen.dart';
// import 'package:flutter/material.dart';

// import '../common/my_const.dart';
// import '../common/my_helper.dart';
// import '../models/auth/login_model.dart';
// import '../service/api.dart';

// class AuthProvider with ChangeNotifier {
//   Data? profile;

//   Future<void> login(var params) async {
//     var data = await API.post(API.apiUrl + 'auth/login', params);

//     // print(data);
//     var result = LoginModel.fromJson(data);

//     if (result.status == true) {
//       await MyHelper.setPref(
//           MyConst.loginData, jsonEncode(result.data!.toJson()));
//       API.init();

//       MyHelper.navPushReplacement(const MainMenuScreen());

//       MyHelper.toast(result.message!);
//     } else {
//       MyHelper.toast(result.message!);
//     }
//   }

//   Future<void> showProfile() async {
//     profile = null;

//     var data = await MyHelper.getPref(MyConst.loginData);

//     var result = Data.fromJson(jsonDecode(data!));

//     profile = result;

//     notifyListeners();
//   }
// }
