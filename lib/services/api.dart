import 'package:dio/dio.dart';

import '../common/my_helper.dart';

var dio = Dio();

class API {
  static String webUrl = "http://warkahpintar.teknoborneo.com/";
  static String apiUrl = "http://warkahpintar.teknoborneo.com/api/";

  static Future<void> init() async {
    dio = Dio(BaseOptions(
        connectTimeout: 15000,
        receiveTimeout: 15000,
        contentType: "application/json",
        responseType: ResponseType.json));

    await setDioHeader();
    await setTokenHeader();
  }

  static Future<void> setDioHeader() async {
    dio.options.headers = {'accept': 'application/json'};
  }

  static Future<void> setTokenHeader() async {
    // var token = await MyHelper.getPref(MyConst.bearerToken);
    // if (token != null) {
    //   dio.options.headers.putIfAbsent("Authorization", () => token);
    // }
  }

  static Future<dynamic> get(String url, var params) async {
    try {
      Response response = await dio.get(
        url,
        queryParameters: params,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        if (response.statusCode == 401) {
          MyHelper.toast("Sesi berakhir");
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => const LoginScreen()),
          //     (Route<dynamic> route) => false);
        } else {
          MyHelper.toast("Something Wrong");
          return null;
        }
      }
    } catch (e) {
      MyHelper.toast(e.toString());
      MyHelper.printDebug(e.toString());
      return null;
    }
  }

  static Future<dynamic> post(String url, var params) async {
    try {
      Response response = await dio.post(url, data: params //for post method
          );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        if (response.statusCode == 401) {
          MyHelper.toast("Sesi berakhir");
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => const LoginScreen()),
          //     (Route<dynamic> route) => false);
        } else {
          MyHelper.toast("Something Wrong");
          return null;
        }
      }
    } catch (e) {
      MyHelper.toast(e.toString());
      MyHelper.printDebug(e.toString());
      return null;
    }
  }

  static Future<dynamic> postMiltipart(String url, var params, Function() action) async {
    try {
      FormData formData = FormData.fromMap(params);

      Response response = await dio.post(
        url,
        data: formData, //for post method
        onSendProgress: (int sent, int total) {
          action();
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response.data;
      } else {
        if (response.statusCode == 401) {
          MyHelper.toast("Sesi berakhir");
          // Navigator.of(context).pushAndRemoveUntil(
          //     MaterialPageRoute(builder: (context) => const LoginScreen()),
          //     (Route<dynamic> route) => false);
        } else {
          MyHelper.toast("Something Wrong");
          return null;
        }
      }
    } catch (e) {
      MyHelper.toast(e.toString());
      MyHelper.printDebug(e.toString());
      return null;
    }
  }
}
