import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/store/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chatty/common/entities/msg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:chatty/pages/contact/state.dart';
import 'package:get/get.dart';

import '../../common/routes/names.dart';

class ContactController extends GetxController {
  ContactController();

  final title = "TSW Chat .";
  final state = ContactState();
  final token = UserStore.to.profile.token;
  final db = FirebaseFirestore.instance;

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }
  //แบบคุยกัน ตัวต่อตัว
  // Future<void> goChat(ContactItem contactItem) async {
  //
  //   var from_messages = await db.collection("message").withConverter(
  //     fromFirestore: Msg.fromFirestore,
  //     toFirestore: (Msg msg, options) => msg.toFirestore(),
  //   ).where("from_token", isEqualTo: token).where("to_token", isEqualTo: contactItem.token).get();
  //
  //   var to_messages = await db.collection("message").withConverter(
  //      fromFirestore: Msg.fromFirestore,
  //      toFirestore: (Msg msg, options) => msg.toFirestore(),
  //    ).where("from_token", isEqualTo: contactItem.token).where("to_token", isEqualTo: token).get();
  //
  //   if(from_messages.docs.isEmpty && to_messages.docs.isEmpty){
  //
  //
  //     var profile = UserStore.to.profile;
  //     var msgdata = Msg(
  //       from_token: profile.token,
  //       to_token: contactItem.token,
  //       from_name: profile.name,
  //       to_name: contactItem.name,
  //       from_avatar: profile.avatar,
  //       to_avatar: contactItem.avatar,
  //       from_online: profile.online,
  //       to_online: contactItem.online,
  //       last_msg: "",
  //       last_time: Timestamp.now(),
  //       msg_num: 0,
  //     );
  //     var doc_id = await db.collection('message').withConverter(
  //         fromFirestore: Msg.fromFirestore,
  //         toFirestore: (Msg msg,options)=>msg.toFirestore()
  //     ).add(msgdata);
  //     print(doc_id);
  //     Get.toNamed(AppRoutes.Chat,
  //         parameters: {
  //           "doc_id":doc_id.id,
  //           "to_token":contactItem.token??"",
  //           "to_name":contactItem.name??"",
  //           "to_avatar":contactItem.avatar??"",
  //           "to_online": contactItem.online.toString()}
  //     );
  //   }else {
  //     if(!from_messages.docs.isEmpty){
  //       print("---from_messages");
  //       print(from_messages.docs.first.id);
  //       Get.toNamed("/chat", parameters: {"doc_id": from_messages.docs.first.id,"to_token":contactItem.token??"","to_name":contactItem.name??"","to_avatar":contactItem.avatar??"","to_online":contactItem.online.toString()});
  //     }
  //     if(!to_messages.docs.isEmpty){
  //       print("---to_messages");
  //       print(to_messages.docs.first.id);
  //       Get.toNamed("/chat", parameters: {"doc_id": to_messages.docs.first.id,"to_token":contactItem.token??"","to_name":contactItem.name??"","to_avatar":contactItem.avatar??"","to_online":contactItem.online.toString()});
  //     }
  //   }
  // }

  Future<void> goChat(ContactItem contactItem) async {

    //มีห้องแล้วหรือยัง
    var from_messages = await db.collection("message").withConverter(
      fromFirestore: Msg.fromFirestore,
      toFirestore: (Msg msg, options) => msg.toFirestore(),
    ).where("to_token", isEqualTo: contactItem.token).get();

    // var to_messages = await db.collection("message").withConverter(
    //   fromFirestore: Msg.fromFirestore,
    //   toFirestore: (Msg msg, options) => msg.toFirestore(),
    // ).where("from_token", isEqualTo: contactItem.token).where("to_token", isEqualTo: token).get();


    if(contactItem.token=='105239f4-79e8-4649-9f80-896bcf8d29e2'){// คุยกับadmin
      print('token :${token}');
      print('contactItem.token :${contactItem.token}');

      var from_messages = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore(),
      ).where("from_token", isEqualTo: token).where("to_token", isEqualTo: contactItem.token).get();

      var to_messages = await db.collection("message").withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg, options) => msg.toFirestore(),
      ).where("from_token", isEqualTo: contactItem.token).where("to_token", isEqualTo: token).get();

      if(from_messages.docs.isEmpty && to_messages.docs.isEmpty){
          var profile = UserStore.to.profile;
          var msgdata = Msg(
            from_token: profile.token,
            to_token: contactItem.token,
            from_name: profile.name,
            to_name: contactItem.name,
            from_avatar: profile.avatar,
            to_avatar: contactItem.avatar,
            from_online: profile.online,
            to_online: contactItem.online,
            last_msg: "",
            last_time: Timestamp.now(),
            msg_num: 0,
          );
          var doc_id = await db.collection('message').withConverter(
              fromFirestore: Msg.fromFirestore,
              toFirestore: (Msg msg,options)=>msg.toFirestore()
          ).add(msgdata);
          print(doc_id);
          Get.toNamed(AppRoutes.Chat,
              parameters: {
                "doc_id":to_messages.docs.first.id,
                "to_token":contactItem.token??"",
                "to_name":contactItem.name??"",
                "to_avatar":contactItem.avatar??"",
                "from_avater":msgdata.from_avatar??"",
                "to_online": contactItem.online.toString()}
          );
        }else {
        var profile = UserStore.to.profile;
        var msgdata = Msg(
          from_token: profile.token,
          to_token: contactItem.token,
          from_name: profile.name,
          to_name: contactItem.name,
          from_avatar: profile.avatar,
          to_avatar: contactItem.avatar,
          from_online: profile.online,
          to_online: contactItem.online,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0,
        );
          if(!from_messages.docs.isEmpty){
            print("---from_messages");
            print(from_messages.docs.first.id);
            Get.toNamed("/chat", parameters: {
              "doc_id": from_messages.docs.first.id,
              "to_token":contactItem.token??"",
              "to_name":contactItem.name??"",
              "to_avatar":contactItem.avatar??"",
              "from_avatar": msgdata.from_avatar??"",
              "to_online":contactItem.online.toString()}
            );
          }
          if(!to_messages.docs.isEmpty){
            print("---to_messages");
            print(to_messages.docs.first.id);
            Get.toNamed("/chat", parameters: {
              "doc_id": to_messages.docs.first.id,
              "to_token":contactItem.token??"",
              "to_name":contactItem.name??"",
              "to_avatar":contactItem.avatar??"",
              "from_avatar": msgdata.from_avatar??"",
              "to_online":contactItem.online.toString()});
          }
        }

    }else{
      if(from_messages.docs.isEmpty){

        var profile = UserStore.to.profile;
        var msgdata = Msg(
          from_token: profile.token,
          to_token: contactItem.token,
          from_name: profile.name,
          to_name: contactItem.name,
          from_avatar: profile.avatar,
          to_avatar: contactItem.avatar,
          from_online: profile.online,
          to_online: contactItem.online,
          last_msg: "",
          last_time: Timestamp.now(),
          msg_num: 0,
        );
        var doc_id = await db.collection('message').withConverter(
            fromFirestore: Msg.fromFirestore,
            toFirestore: (Msg msg,options)=>msg.toFirestore()
        ).add(msgdata);
        print(doc_id);
        Get.toNamed(AppRoutes.Chat,
            parameters: {
              "doc_id":doc_id.id,
              "to_token":contactItem.token??"",
              "to_name":contactItem.name??"",
              "to_avatar":contactItem.avatar??"",
              "to_online": contactItem.online.toString(),
              "from_avatar": msgdata.from_avatar??"",
        }
        );


      }else {
        if(!from_messages.docs.isEmpty){
          var profile = UserStore.to.profile;
          var msgdata = Msg(
            from_token: profile.token,
            to_token: contactItem.token,
            from_name: profile.name,
            to_name: contactItem.name,
            from_avatar: profile.avatar,
            to_avatar: contactItem.avatar,
            from_online: profile.online,
            to_online: contactItem.online,
            last_msg: "",
            last_time: Timestamp.now(),
            msg_num: 0,
          );
          print("---from_messages");
          print(from_messages.docs.first.id);
          Get.toNamed("/chat", parameters: {
            "doc_id": from_messages.docs.first.id,
            "to_token":contactItem.token??"",
            "to_name":contactItem.name??"",
            "to_avatar":contactItem.avatar??"",
            "from_avatar": msgdata.from_avatar??"",
            "to_online":contactItem.online.toString()
          });
        }

      }
    }

  }


  asyncLoadAllData() async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    state.contactList.clear();
    var result = await ContactAPI.post_contact();
    if (kDebugMode) {
      print('  ${result.data!}');
    }
    if (result.code == 200) {
      state.contactList.addAll(result.data!);
    }
    EasyLoading.dismiss();
  }
}
