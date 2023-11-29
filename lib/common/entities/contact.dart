

import 'package:chatty/common/entities/pinmessage.dart';

class ContactResponseEntity {
  int? code;
  String? msg;
  List<ContactItem>? data;

  ContactResponseEntity({
    this.code,
    this.msg,
    this.data,
  });
  factory ContactResponseEntity.fromJson(Map<String, dynamic> json) =>
      ContactResponseEntity(
        code: json["statusCode"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<ContactItem>.from(json["data"].map((x) => ContactItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "counts": code ,
    "msg": msg ,
    "data": data == null
        ? []
        : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

// login result
class ContactItem {
  String? token;
  String? name;
  String? description;
  String? avatar;
  int? online;
  String? roomPass;
  List<PinMessageResponseEntity>? pin;

  ContactItem({
    this.token,
    this.name,
    this.description,
    this.avatar,
    this.online,
    this.roomPass,
    this.pin,
  });

  factory ContactItem.fromJson(Map<String, dynamic> json) =>
      ContactItem(
        token: json["token"],
        name: json["name"],
        description: json["description"],
        avatar: json["avatar"],
        online: json["online"],
        roomPass: json["roomPass"],
        pin: json["pin"] == null
            ? []
            : List<PinMessageResponseEntity>.from(json["pin"].map((x) => PinMessageResponseEntity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "token": token,
    "name": name,
    "description": description,
    "avatar": avatar,
    "online": online,
    "roomPass": roomPass,
    "pin": pin == null
        ? []
        : List<dynamic>.from(pin!.map((x) => x.toJson())),
  };
}



