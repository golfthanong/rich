import 'package:cloud_firestore/cloud_firestore.dart';

class Msgcontent {
  final String? msglist;
  final String? token;
  final String? content;
  final String? type;
  final Timestamp? addtime;
  final String? from_avatar;
   String? msg_id;

  Msgcontent({
    this.msglist,
    this.token,
    this.content,
    this.type,
    this.addtime,
    this.from_avatar,
    this.msg_id,
  });

  factory Msgcontent.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return Msgcontent(
      msg_id: data?['msg_id'],
      token: data?['token'],
      content: data?['content'],
      type: data?['type'],
      addtime: data?['addtime'],
      from_avatar: data?['from_avatar'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (msglist != null) "msglist": msglist,
      if (token != null) "token": token,
      if (content != null) "content": content,
      if (type != null) "type": type,
      if (addtime != null) "addtime": addtime,
      if (from_avatar != null) "from_avatar": from_avatar,
      if (msg_id != null) "msg_id": msg_id,
    };
  }
}