import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/entities/pinmessage.dart';
import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/store/user.dart';
import 'package:chatty/common/widgets/toast.dart';
import 'dart:io';
import 'package:chatty/pages/message/chat/state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/values/colors.dart';


// class PinMessageController extends GetxController{
//   PinMessageController();
//   final state = ChatState();
// }

class ChatController extends GetxController {
  ChatController();

  final state = ChatState();
  final pinstate = PinState();
  late String doc_id;
  final myInputController = TextEditingController();
  //get the user or sender's token
  final token = UserStore.to.profile.token;
  //firebase data intance
  final db = FirebaseFirestore.instance;
  var listener ;
  var isLoadmore = true;
  File? _photo;

  ScrollController myScrollController = ScrollController();



  @override
  Future<void> onReady() async {
    super.onReady();



    if (state.roomPass.value != "") {
      _showFullScreenDialog();
    }
    asyncLoadPinMesageData();


    state.msgcontentList.clear();
    final messages = db.collection('message')
                       .doc(doc_id)
                       .collection('msglist')
                       .withConverter(
                          fromFirestore: Msgcontent.fromFirestore,
                          toFirestore: (Msgcontent msg,options)=>msg.toFirestore()
                        ).orderBy('addtime',descending: true).limit(15);

    // var messageResult = await db.collection('message').doc(doc_id).withConverter(
    //     fromFirestore: Msg.fromFirestore,
    //     toFirestore: (Msg msg,options)=>msg.toFirestore()
    // ).get();
    // print('golgggggg.........${messageResult.data()}');

    listener = messages.snapshots().listen((event) {
      List<Msgcontent> tempMsgList = <Msgcontent>[];
      print('gol.........${event.docChanges.length}');
      for(var change in event.docChanges){
        switch(change.type){

          case DocumentChangeType.added:
            // TODO: Handle this case.
            if(change.doc.data() !=null){
              Msgcontent msgtemp = change.doc.data()!;
              msgtemp.msg_id = change.doc.id!;
              tempMsgList.add(msgtemp!);
              print('${change.doc.data()!}');
              print('doc id ${change.doc.id}');
              print('doc id ${msgtemp}');

              print('.... new added ${myInputController.text}');
              tempMsgList.reversed.forEach((element) {
                state.msgcontentList.value.insert(0, element);
              });
            }
            break;
          case DocumentChangeType.modified:
            // TODO: Handle this case.
            // if(change.doc.data() !=null){
            //   tempMsgList.add(change.doc.data()!);
            //   print('${change.doc.data()!}');
            //   print('.... new  modified${myInputController.text}');
            //   tempMsgList.reversed.forEach((element) {
            //     state.msgcontentList.value.insert(0, element);
            //   });
            // }
            if (change.doc.data() != null) {
              Msgcontent modifiedMsg = change.doc.data()!;
              modifiedMsg.msg_id = change.doc.id;

              // Find the index of the modified message in your list
              int modifiedIndex = state.msgcontentList.value.indexWhere(
                    (element) => element.msg_id == modifiedMsg.msg_id,
              );

              if (modifiedIndex != -1) {
                // Replace the old message with the modified message
                state.msgcontentList.value[modifiedIndex] = modifiedMsg;
              }
            }
            break;
          case DocumentChangeType.removed:
            // TODO: Handle this case.
            break;
        }

      }
      // tempMsgList.reversed.forEach((element) {
      //   state.msgcontentList.value.insert(0, element);
      // });state.msgcontentList.refresh();


      if(myScrollController.hasClients){
        myScrollController.animateTo(
          //point to the very top of your list
          // lowest index
          myScrollController.position.minScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
        );
      }
    });

    myScrollController.addListener(() {
      if(myScrollController.offset+20>myScrollController.position.maxScrollExtent){
        if(isLoadmore){
          state.isloading.value = true;
          isLoadmore = false;
          asyncLoadMoreData();
          print('.... loading ....');
        }
      }
    });
  }

  // Future imgFromGallery() async{
  //     final pickedFile =  await _picker.pickImage(source: ImageSource.gallery);
  //     if(pickedFile!=null){
  //       _photo = File(pickedFile.path);
  //       uploadFile();
  //     }else{
  //       print('No image selected');
  //     }
  // }

  // Future launchURL() async{
  //   const url = 'https://www.google.com';
  //   if (await canLaunch(url)) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  void openBrowserURL() async {
    final url = 'http://27.254.82.236:8000/note/${state.to_token.value}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
    print(state.to_token.value);
  }




  Future uploadFile() async{
    var result = await ChatAPI.upload_img(file:_photo);
    print(result.data);
    if(result.code==0){
      sendImageMessage(result.data!);
    }else{
      toastInfo(msg: 'sending image error');
    }
  }

  Future<void> asyncLoadMoreData() async {
    final messages = await db.collection("message")
                    .doc(doc_id)
                    .collection('msglist')
                    .withConverter(
                    fromFirestore: Msgcontent.fromFirestore,
                    toFirestore: (Msgcontent msg,optins)=>msg.toFirestore()
                    ).orderBy('addtime',descending: true)
                    .where(
                      'addtime',isLessThan: state.msgcontentList.value.last.addtime
                    ).limit(10).get();
    if(messages.docs.isNotEmpty){
      messages.docs.forEach((element) {
        var data  = element.data();
        state.msgcontentList.value.add(data);
      });
    }

    SchedulerBinding.instance.addPersistentFrameCallback((timeStamp) {
      isLoadmore = true;
    });
    state.isloading.value =false;
  }

  @override
  void onInit(){
    super.onInit();

    var data =Get.parameters;

    doc_id = data['doc_id']!;
    state.to_token.value = data['to_token']??"";
    state.to_name.value = data['to_name']??"";
    state.to_avatar.value = data['to_avatar']??"";
    state.to_online.value = data['to_online']??"1";
    state.from_avatar.value = data['from_avatar']??"";
    state.from_name.value = data['from_name']??"";
    state.roomPass.value = data['roomPass']??"";

  }

  void closeAllPop() async{
    Get.focusScope?.unfocus();
    state.more_status.value = false;
    pinstate.show_more_status.value=false;
    pinstate.show_more_message_pin.value=false;

  }


  void goMore(){
    state.more_status.value = state.more_status.value?false:true;
  }


  void goShowPinMessage(){
    pinstate.show_more_status.value=pinstate.show_more_status.value?false:true;
  }

  void goShowMorePinMessage(){
    pinstate.show_more_message_pin.value=pinstate.show_more_message_pin.value?false:true;
  }


  Future<void> UpdateToDeleteMessage( msg_id) async {

    await db.collection("message").doc(doc_id).collection('msglist')
        .doc(msg_id) // Replace 'documentId' with the ID of the document you want to update
        .update({
      'type': 'cancel', // Replace 'updatedContent' with the new content

    })
        .then((_) {
      // Update was successful
      myInputController.clear();
    })
        .catchError((error) {
      // Handle the error if the update fails
      print("Error updating document: $error");
    });





  }


  Future<void> sendMessage() async {
    String sendContent = myInputController.text;

    if(sendContent.isEmpty){
      toastInfo(msg: 'content is empty');
      return;
    }

    //created on object to send back to firebase
    final content = Msgcontent(
        token:token,
        content: sendContent,
        type: "text",
        addtime: Timestamp.now(),
      from_name: state.from_name.value,
        from_avatar: state.from_avatar.value,

    );

    await db.collection("message").doc(doc_id).collection('msglist')
        .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg,options)=>msg.toFirestore()
    ).add(content).then((DocumentReference doc) {

      myInputController.clear();
    });

    var messageResult = await db.collection('message').doc(doc_id).withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg,options)=>msg.toFirestore()
    ).get();
    if(messageResult.data() !=null){
      var item = messageResult.data()!;
      int to_msg_num = item.to_msg_num==null?0:item.to_msg_num!;
      int from_msg_num = item.from_msg_num==null?0:item.from_msg_num!;
      if(item.from_token==token){
        from_msg_num = from_msg_num+1;
      }else{
        to_msg_num = to_msg_num+1;
      }
      await db.collection('message').doc(doc_id).update({
        'to_msg_num':to_msg_num,
        'from_msg_num':from_msg_num,
        'last_msg': sendContent,
        'last_time':Timestamp.now()
      });
    }
  }


  Future<void> sendImageMessage(String url) async {


    //created on object to send back to firebase
    final content = Msgcontent(
        token:token,
        content: url,
        type: "image",
        addtime: Timestamp.now()
    );

    await db.collection("message").doc(doc_id).collection('msglist')
        .withConverter(
        fromFirestore: Msgcontent.fromFirestore,
        toFirestore: (Msgcontent msg,options)=>msg.toFirestore()
    ).add(content).then((DocumentReference doc) {

      print('...base id is ${doc_id}...new image doc id is ${doc.id}');
    });

    var messageResult = await db.collection('message').doc(doc_id).withConverter(
        fromFirestore: Msg.fromFirestore,
        toFirestore: (Msg msg,options)=>msg.toFirestore()
    ).get();
    if(messageResult.data() !=null){
      var item = messageResult.data()!;
      int to_msg_num = item.to_msg_num==null?0:item.to_msg_num!;
      int from_msg_num = item.from_msg_num==null?0:item.from_msg_num!;
      if(item.from_token==token){
        from_msg_num = from_msg_num+1;
      }else{
        to_msg_num = to_msg_num+1;
      }
      await db.collection('message').doc(doc_id).update({
        'to_msg_num':to_msg_num,
        'from_msg_num':from_msg_num,
        'last_msg': "⸢image⸣",
        'last_time':Timestamp.now()
      });
    }
  }

  void _showFullScreenDialog() {
    TextEditingController _textController = TextEditingController();

    Get.dialog(
      Scaffold(



        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              SizedBox(height: 16.0),
              TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter Password Room ${state.to_name}',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [


                  ElevatedButton(
                    onPressed: () {
                      // Handle OK button logic, e.g., save the input text
                      String enteredText = _textController.text;
                      if (enteredText== state.roomPass.value) {
                        Get.back(); // Close the dialog
                      }else{
                        _textController.text = "";
                      }
                    },
                    child: Text('OK'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.back();
                      Get.offAllNamed(AppRoutes.Message);// Close the dialog on Cancel
                    },
                    child: Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }










  @override
  void onClose(){
    super.onClose();
    listener.cancel();
    myInputController.dispose();
    myScrollController.dispose();
  }
  asyncLoadPinMesageData() async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    // state.PinMessageList.clear();
    pinstate.PinMessageList.clear();
    String golf = state.to_token.value;
    print('token: $golf');
     var result = await ContactAPI.post_contact_room(state.to_token.value);

    if (result.code == 200) {
       //state.contactList.addAll(result.data!);
      pinstate.PinMessageList.addAll(result.data![0].pin as Iterable<PinMessageResponseEntity>);
     }
    EasyLoading.dismiss();
  }
}
