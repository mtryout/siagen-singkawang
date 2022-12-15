// ignore_for_file: prefer_if_null_operators

class LoginModel {
    LoginModel({
        this.status,
        this.message,
        this.accessToken,
        this.tokenType,
    });

    bool? status;
    String? message;
    String? accessToken;
    String? tokenType;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"] == null ? null : json["status"],
        message: json["message"] == null ? null : json["message"],
        accessToken: json["access_token"] == null ? null : json["access_token"],
        tokenType: json["token_type"] == null ? null : json["token_type"],
    );

    Map<String, dynamic> toJson() => {
        "status": status == null ? null : status,
        "message": message == null ? null : message,
        "access_token": accessToken == null ? null : accessToken,
        "token_type": tokenType == null ? null : tokenType,
    };
}