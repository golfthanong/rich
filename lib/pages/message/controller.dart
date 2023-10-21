import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/store/user.dart';
import 'package:chatty/pages/message/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:get/get.dart';

class MessageController extends GetxController {
  MessageController();

  @override
  void onReady() {
    super.onReady();
    asyncLoadAllData();
  }

  final state = MessageState();
  void goProfile() async {
    await Get.toNamed(AppRoutes.Profile,
    arguments: state.head_detail.value
    );
  }

  goTabStatus(){
  state.tabStatus.value = !state.tabStatus.value;
  }

  @override
  void onInit(){
    super.onInit();
    getProfile();

  }

  asyncLoadAllData() async {
    EasyLoading.show(
      indicator: CircularProgressIndicator(),
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
    );
    state.news_messageList.clear();
    var result = await NewsMessageAPI.get_news_message();
    if (kDebugMode) {
      print('aaaaaaaa  ${result.data!}');
    }
    if (result.code == 200) {
      state.news_messageList.addAll(result.data!);
    }
    EasyLoading.dismiss();
  }
  void getProfile() async{
    var profile = await UserStore.to.profile;
    state.head_detail.value = profile;
    state.head_detail.refresh();

  }
}
