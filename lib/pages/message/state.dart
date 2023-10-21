import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/entities/news_message.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageState {
  var head_detail = UserItem().obs;
  RxBool tabStatus = true.obs;
  RxList<Message> mstList = <Message>[].obs;
  RxList<NewsMessageItem> news_messageList = <NewsMessageItem>[].obs;

}
