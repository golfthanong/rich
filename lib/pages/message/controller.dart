import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/store/user.dart';
import 'package:chatty/pages/message/state.dart';

import 'package:get/get.dart';

class MessageController extends GetxController {
  MessageController();

  final state = MessageState();
  void goProfile() async {
    await Get.toNamed(AppRoutes.Profile,
    arguments: state.head_detail.value
    );
  }

  @override
  void onInit(){
    super.onInit();
    getProfile();
  }

  void getProfile() async{
    var profile = await UserStore.to.profile;
    state.head_detail.value = profile;
    state.head_detail.refresh();

  }
}
