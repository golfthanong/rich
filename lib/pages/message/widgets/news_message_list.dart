import 'package:chatty/pages/message/controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../common/entities/news_message.dart';
import '../../../common/values/colors.dart';

class NewsMessageList extends GetView<MessageController> {
  const NewsMessageList({super.key});

  Widget _buildListItem(NewsMessageItem item) {
    return Container(
      padding: EdgeInsets.only(
        top: 10.h,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: AppColors.primarySecondaryBackground,
          ),
        ),
      ),
      child: InkWell(
        onTap: () {
          //controller.goChat(item);
          //controller.goChat(item);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container(
            //   width: 44.w,
            //   height: 44.w,
            //   decoration: BoxDecoration(
            //     color: AppColors.primarySecondaryBackground,
            //     borderRadius: BorderRadius.all(Radius.circular(22.w)),
            //     boxShadow: [
            //       BoxShadow(
            //         color: Colors.grey.withOpacity(0.1),
            //         spreadRadius: 1,
            //         blurRadius: 2,
            //         offset: Offset(0, 1),
            //       ),
            //     ],
            //   ),
            //   child: CachedNetworkImage(
            //     imageUrl: item.img!,
            //     height: 44.w,
            //     width: 44.w,
            //     imageBuilder: (context, imageProvider) => Container(
            //       decoration: BoxDecoration(
            //         borderRadius: BorderRadius.all(Radius.circular(22.w)),
            //         image: DecorationImage(
            //           image: imageProvider,
            //         ),
            //       ),
            //     ),
            //   ),
            //
            // ),
            // Container(
            //   width: 275.w,
            //   padding: EdgeInsets.only(top: 10.w,left: 10.w,right: 0.w,bottom: 0.w),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       SizedBox(
            //         width: 200.w,
            //         height: 42.w,
            //         child: Text('${item.text}',
            //           overflow: TextOverflow.clip,
            //           maxLines: 1,
            //           style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               color: AppColors.thirdElement,
            //               fontSize: 16.sp,
            //               fontFamily: 'Avenir'
            //           ),),
            //
            //       ),
            //       Container(
            //         width: 12.w,
            //         height: 12.w,
            //         margin: EdgeInsets.only(top: 5.w),
            //         child: Image.asset('assets/icons/ang.png'),
            //       )
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //return Obx(() {
      return Container(
        width: 200,          // Width of the container
        height: 800.h,         // Height of the container
        color: Colors.white,   // Background color of the container
        child: Center(
          // child: Text(
          //   'Hello, Flutter! ${controller.state.news_messageList.length}',
          //   style: TextStyle(
          //     fontSize: 20,
          //     color: Colors.red,
          //   ),
          // ),


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
      // return CustomScrollView(
      //   slivers: [
      //     SliverPadding(
      //       padding: EdgeInsets.symmetric(
      //         vertical: 0.w,
      //         horizontal: 20.w,
      //       ),
      //       sliver: SliverList(
      //         delegate: SliverChildBuilderDelegate(
      //               (BuildContext context, int index) {
      //             var item = controller.state.news_messageList[index];
      //
      //             //return _buildListItem(item);
      //                 return Container(
      //                 width: 200,          // Width of the container
      //                 height: 200,         // Height of the container
      //                 color: Colors.red,   // Background color of the container
      //                 child: Center(
      //                 child: Text(
      //                 'Hello, Flutter!',
      //                 style: TextStyle(
      //                 fontSize: 20,
      //                 color: Colors.white,
      //             ),
      //                 ),
      //                 ),
      //                 );
      //           },
      //           childCount: controller.state.news_messageList.length,
      //         ),
      //       ),
      //     ),
      //   ],
      // );
    //});
  }
}
