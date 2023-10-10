

class PinMessageResponseEntity {
  int? id;
  String? message;
  bool? isActive;

  PinMessageResponseEntity({
    this.id,
    this.message,
    this.isActive,
  });
  factory PinMessageResponseEntity.fromJson(Map<String, dynamic> json) =>
      PinMessageResponseEntity(
        id: json["id"],
        message: json["message"],
        isActive: json["isActive"] ,
      );

  Map<String, dynamic> toJson() => {
    "counts": id ,
    "msg": message ,
    "data": isActive ,
  };
}




