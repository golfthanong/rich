import 'package:chatty/common/values/colors.dart';
import 'package:chatty/pages/message/chat/controller.dart';
import 'package:chatty/pages/message/chat/widgets/pin_message_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../common/entities/pinmessage.dart';


class PinMessageList extends GetView<ChatController> {
  const PinMessageList({super.key});


  Widget _buildListItem(BuildContext context, PinMessageResponseEntity? pinItem) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          context: context,
          //isScrollControlled: true,
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 0.3, // Adjust the height factor as needed
              child: PinMessageDetailScreen(pinItem?.message ?? "Default Text"),
            );
          },
        );
      },
      child: Container(
        color: AppColors.primarySecondaryBackground,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  pinItem?.message ?? "Default Text",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: AppColors.primaryThreeElementText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }









  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SizedBox(
        height: 200, // Set an appropriate height
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.symmetric(),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    var item = controller.pinstate.PinMessageList[index];

                    return _buildListItem(context,item);
                  },
                  childCount: controller.pinstate.PinMessageList.length,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }





}
