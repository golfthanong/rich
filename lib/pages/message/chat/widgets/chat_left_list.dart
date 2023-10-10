import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import '../../../../common/values/server.dart';
import '../controller.dart';

class ChatLeftList extends GetView<ChatController> {
  final Msgcontent item;

  ChatLeftList(this.item);

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
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          ),
          SizedBox(width: 3.w),
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
                      ? Text(
                    '${item.content}',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.primaryElementText,
                    ),
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
                    onTap: () {
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
                    },
                  )
                      : ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 90.w,
                    ),
                    child: GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: imagePath!,
                      ),
                      onTap: () {
                        //controller.pinstate.show_more_status.value
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
