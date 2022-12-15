
import 'package:flutter/material.dart';
import 'package:singkawang/common/my_const.dart';
import 'package:singkawang/screens/mainmenu/main_menu.dart';

import '../common/my_helper.dart';
import '../models/auth/login_model.dart';
import '../services/api.dart';

class AuthProvider with ChangeNotifier {
  bool loading = false;

  Future<void> login(var params) async {
    loading = true;
    notifyListeners();
    
    var data = await API.post('${API.apiUrl}login', params);

    // print(data);
    var result = LoginModel.fromJson(data);

    if (result.status!) {
      await MyHelper.setPref(
          MyConst.bearer, result.accessToken);
      API.init();

      MyHelper.navPushReplacement(const MainMenu());

      MyHelper.toast(result.message!);
    } else {
      MyHelper.toast(result.message!);
    }
     loading = false;
    notifyListeners();
  }

  // Future<void> showProfile() async {
  //   profile = null;

  //   var data = await MyHelper.getPref(MyConst.loginData);

  //   var result = Data.fromJson(jsonDecode(data!));

  //   profile = result;

  //   notifyListeners();
  // }
}
