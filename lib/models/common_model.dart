// ignore_for_file: prefer_if_null_operators

class CommonModel {
  CommonModel({
    this.message,
    this.status,
    this.detail,
  });

  String? message;
  bool? status;
  dynamic detail;

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
        message: json["message"] == null ? null : json["message"],
        status: json["status"] == null ? null : json["status"],
        detail: json["detail"],
      );

  Map<String, dynamic> toJson() => {
        "message": message == null ? null : message,
        "status": status == null ? null : status,
        "detail": detail,
      };
}
