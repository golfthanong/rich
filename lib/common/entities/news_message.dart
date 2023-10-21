
class NewsMessageResponseEntity {
  int? code;
  String? msg;
  List<NewsMessageItem>? data;

  NewsMessageResponseEntity({
    this.code,
    this.msg,
    this.data,
  });
  factory NewsMessageResponseEntity.fromJson(Map<String, dynamic> json) =>
      NewsMessageResponseEntity(
        code: json["statusCode"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<NewsMessageItem>.from(json["data"].map((x) => NewsMessageItem.fromJson(x))),
      );
  Map<String, dynamic> toJson() => {
    "counts": code ,
    "msg": msg ,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class NewsMessageItem {
  String? img;
  String? text;
  String? datetime;


  NewsMessageItem({
    this.img,
    this.text,
    this.datetime,

  });

  factory NewsMessageItem.fromJson(Map<String, dynamic> json) =>
      NewsMessageItem(
        img: json["img"],
        text: json["text"],
        datetime: json["datetime"],

      );

  Map<String, dynamic> toJson() => {
    "img": img,
    "text": text,
    "datetime": datetime,

  };
}
