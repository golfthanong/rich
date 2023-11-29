import 'package:get/get.dart';
import 'package:chatty/common/entities/entities.dart';

import '../../../common/entities/pinmessage.dart';

class ChatState {
  //for holding our data from firebase firestore
  RxList<Msgcontent> msgcontentList = <Msgcontent>[].obs;
  var to_token = ''.obs;
  var to_name = ''.obs;
  var to_avatar = ''.obs;
  var to_online = ''.obs;
  var from_avatar = ''.obs;
  var from_name = ''.obs;
  var msg_id = ''.obs;
  var roomPass = ''.obs;
  RxBool more_status = false.obs;
  RxBool isloading = false.obs;


}
class PinState {
  //for holding our data from firebase firestore
  RxList<PinMessageResponseEntity> PinMessageList = <PinMessageResponseEntity>[].obs;
  var to_id = 0.obs;
  var to_messsage = ''.obs;
  RxBool is_active_status = false.obs;
  RxBool show_more_status = false.obs;
  RxBool show_more_message_pin = false.obs;


}
