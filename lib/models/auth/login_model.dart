// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.message,
        this.accessToken,
        this.tokenType,
    });

    String? message;
    String? accessToken;
    String? tokenType;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        message: json["message"] == null ? null : json["message"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
        tokenType: json["token_type"] == null ? null : json["token_type"],
    );

    Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "access_token": accessToken == null ? null : accessToken,
        "token_type": tokenType == null ? null : tokenType,
    };
}