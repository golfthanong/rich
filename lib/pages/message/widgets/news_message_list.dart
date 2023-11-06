import 'package:chatty/pages/message/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common/entities/news_message.dart';
import '../../../common/values/colors.dart';

class NewsMessageList extends GetView<MessageController> {
  const NewsMessageList({super.key});



  @override
  Widget build(BuildContext context) {
    //return Obx(() {
      return Container(
        width: 200,          // Width of the container
        height: 800.h,         // Height of the container
        color: Colors.white,   // Background color of the container
        child: Center(



            child: ListView.builder(
              itemCount: controller.state.news_messageList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.network('${controller.state.news_messageList[index].img}'),
                      SizedBox(height: 30),
                      Text('${controller.state.news_messageList[index].text}'),
                      Text('วันที่ข่าว   ${controller.state.news_messageList[index].datetime}'),
                      SizedBox(height: 40),
                    ],
                  ),
                );
              },
            )


        ),
      );

  }
}
