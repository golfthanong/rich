import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/values/colors.dart';
import 'package:chatty/common/values/server.dart';
import 'package:chatty/pages/message/chat/widgets/popup_delete_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chatty/pages/message/chat/controller.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class ChatRightList extends GetView<ChatController> {
  final Msgcontent item;

  ChatRightList(this.item);

  @override
  Widget build(BuildContext context) {
    var imagePath = null;

    if (item.type == 'image') {
      imagePath = item.content?.replaceAll('http://localhost', SERVER_API_URL);
    }

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.w,
        horizontal: 20.w,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 250.w,
              maxHeight: 60.h,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: item.type == "text"?AppColors.primaryElement
                        :item.type == "cancel"?AppColors.primarySecondaryBackground
                        :AppColors.primaryElement,
                    borderRadius: BorderRadius.all(Radius.circular(5.w)),
                  ),
                  padding: EdgeInsets.only(
                    top: 10.w,
                    bottom: 10.w,
                    left: 10.w,
                    right: 10.w,
                  ),
                  child: item.type == "text"
                      ? GestureDetector(
                        child: Container(
                          child: Text(
                    '${item.content} ',
                    style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.primaryElementText,
                    ),
                            softWrap: true,
                  ),
                        ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Delete Message"),
                            content: Text("Are you sure you want to delete this message?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  // Perform the delete operation here
                                  controller.UpdateToDeleteMessage(item.msg_id); // Call your controller function
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },      //เอาไว้ update ว่ายกเลิกข้อความ

                  )

                 : item.type == "cancel"  // Check if item.type is "cancel"
                      ? GestureDetector(
                    child: Container(
                      child: Text(
                        'ข้อความถูกยกเลิก', // Display "Cancel" text for the "cancel" type
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.thirdElement,  // You can specify the color for "cancel" type
                        ),
                      ),
                    ),
                   /* onTap: () {
                      // Handle the "cancel" action here
                      // For example, you can show a confirmation dialog or perform an action
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Cancel Action"),
                            content: Text("Are you sure you want to cancel this action?"),
                            actions: [
                              TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                              TextButton(
                                child: Text("OK"),
                                onPressed: () {
                                  // Perform the cancel action here
                                  // You can update your controller or perform any required action
                                  // controller.PerformCancelAction();
                                  Navigator.of(context).pop(); // Close the dialog
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },*/   //กด type เป็น cancel แล้วจะทำอะไรต่อไหม
                  )


                      : ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 90.w,
                    ),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: imagePath!,
                      ),
                      onTap: () {},
                    ),
                  ),
                ),
              ],
            ),
          ),


         //ฝั่งตัวเองไม่ต้องแสดงรูปตัวเอง
         /* SizedBox(width: 3.w),
          Container(
            width: 44.w,
            height: 44.w,
            child: CachedNetworkImage(
              imageUrl: item.from_avatar!,
              imageBuilder: (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.w),
                  image: DecorationImage(image: imageProvider),
                ),
              ),
              errorWidget: (context, url, error) => Image(
                image: AssetImage('assete/images/account_header.png'),
              ),
            ),
          ),*/
          //ฝั่งตัวเองไม่ต้องแสดงรูปตัวเอง


        ],
      ),
    );
  }
}

