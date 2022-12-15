class NewsModel {
  String? id;
  String? title;
  String? content;
  String? createdat;
  String? gambar;
  bool? status;
  String? message;

  NewsModel(
      {this.id,
      this.title,
      this.content,
      this.createdat,
      this.gambar,
      this.status,
      this.message});

  NewsModel.fromJson(Map<String, dynamic> json) {
    id = '${json["id"]}';
    title = '${json["title"]}';
    content = '${json["content"]}';
    createdat = '${json["created_at"]}';
    gambar = '${json["gambar"]}';
    status = json["status"];
    message = '${json["message"]}';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["content"] = content;
    data["created_at"] = createdat;
    data["gambar"] = gambar;
    data["status"] = status;
    data["message"] = message;
    return data;
  }
}