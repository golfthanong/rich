import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/common/values/colors.dart';
import 'package:chatty/pages/message/chat/controller.dart';
import 'package:chatty/pages/message/chat/widgets/chat_list.dart';
import 'package:chatty/pages/message/chat/widgets/pin_message_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

class ChatPage extends GetView<ChatController> {
  const ChatPage({Key? key}) : super(key: key);

  AppBar _buildAppBar() {
    return AppBar(
      title: Obx(() {
        return Container(
          child: Text(
            '${controller.state.to_name}',
            overflow: TextOverflow.clip,
            maxLines: 1,
            style: TextStyle(
              fontFamily: 'Avenir',
              fontWeight: FontWeight.bold,
              color: AppColors.primaryText,
              fontSize: 12.sp,
            ),
          ),
        );
      }),
      actions: [
        Container(
          margin: EdgeInsets.only(right: 20.w),
          child: Stack(
            alignment: Alignment.center,
            children: [
              GestureDetector(
                onTap: (){
                  controller.openBrowserURL();
                },
                child: Container(
                  width: 44.w,
                  height: 44.w,
                  child:Image.asset('assets/icons/note.png'),
                  // CachedNetworkImage(
                  //   imageUrl: controller.state.to_avatar.value,
                  //   imageBuilder: (context, imageProvider) => Container(
                  //     decoration: BoxDecoration(
                  //       borderRadius: BorderRadius.circular(22.w),
                  //       image: DecorationImage(image: imageProvider),
                  //     ),
                  //   ),
                  //   errorWidget: (context, url, error) => Image(
                  //     image: AssetImage('assete/images/account_header.png'),
                  //   ),
                  // ),
                ),
              ),
              Positioned(
                bottom: 5.w,
                right: 0.w,
                height: 14.w,
                child: Container(
                  width: 14.w,
                  height: 14.w,
                  decoration: BoxDecoration(
                    color: controller.state.to_online.value == '1'
                        ? AppColors.primaryElementStatus
                        : AppColors.primarySecondaryElementText,
                    borderRadius: BorderRadius.circular(12.w),
                    border: Border.all(
                      width: 2,
                      color: AppColors.primaryElementText,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Obx(
        () => SafeArea(
          child: Stack(
            children: [
              const ChatList(),
              _pinMessage(),

              Positioned(
                top: 50.h,
                left: 0.w,
                right: 0.w,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: controller.pinstate.show_more_status.value
                      ? const PinMessageList()
                      : Container(),
                ),
              ),
              Positioned(
                top: 20.h,
                left: 20.w,
                right: 0.w,
                bottom: 20.w,
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  switchInCurve: Curves.easeIn,
                  switchOutCurve: Curves.easeOut,
                  child: controller.pinstate.show_more_message_pin.value
                      ? _pinMessageFullScreen()
                      : Container(),
                ),
              ),







              Positioned(
                bottom: 0.h,

                child: Container(
                    width: 360.w,
                    padding:
                        EdgeInsets.only(left: 20.w, bottom: 20.h, right: 20.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        //for text fileds and send messages
                        Container(
                          width: 270.w,
                          padding: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.w),
                            color: AppColors.primaryBackground,
                            border: Border.all(
                                color: AppColors.primarySecondaryElementText),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: 220.w,
                                child: TextField(
                                  controller: controller.myInputController,
                                  keyboardType: TextInputType.multiline,
                                  decoration: InputDecoration(
                                    hintText: "Message....",
                                    contentPadding: EdgeInsets.only(
                                      left: 15.w,
                                      top: 0,
                                      bottom: 0,
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    disabledBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Colors.transparent,
                                      ),
                                    ),
                                    hintStyle: const TextStyle(
                                      color:
                                          AppColors.primarySecondaryElementText,
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                child: Container(
                                  width: 40.w,
                                  height: 40.w,
                                  child: Image.asset('assets/icons/send.png'),
                                ),
                                onTap: () {
                                  //send message
                                  controller.sendMessage();
                                },
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          child: Container(
                            height: 40.w,
                            width: 40.w,
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: AppColors.primaryElement,
                              borderRadius: BorderRadius.circular(40.w),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                            child: Image.asset('assets/icons/add.png'),
                          ),
                          onTap: () {
                            controller.goMore();
                          },
                        ),
                      ],
                    )),
              ),
              controller.state.more_status.value
                  ?
              Positioned(
                      right: 20.w,
                      bottom: 70.h,
                      height: 220.h,
                      width: 40.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.w),
                                color: AppColors.primaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              ),
                              child: Image.asset('assets/icons/file.png'),
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.w),
                                color: AppColors.primaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              ),
                              child: Image.asset('assets/icons/photo.png'),
                            ),
                            onTap: () {
                              //controller.imgFromGallery();
                            },
                          ),
                          GestureDetector(
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.w),
                                color: AppColors.primaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              ),
                              child: Image.asset('assets/icons/call.png'),
                            ),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Container(
                              height: 40.h,
                              width: 40.h,
                              padding: EdgeInsets.all(10.w),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40.w),
                                color: AppColors.primaryBackground,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(1, 1),
                                  )
                                ],
                              ),
                              child: Image.asset('assets/icons/video.png'),
                            ),
                            onTap: () {},
                          ),
                        ],
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteBtn() {
    return GestureDetector(
      child: Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 60.h, bottom: .30.h),
        decoration: BoxDecoration(
          color: AppColors.primaryElement,
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: const Offset(0, 1)),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Complete',
              style: TextStyle(
                color: AppColors.primaryElementText,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pinMessage() {
    return GestureDetector(
      child: Container(
        height: 50.h,
        color: AppColors.primarySecondaryBackground,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment
              .spaceBetween, // To place the icon on the right side
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 16.0), // Adjust the padding as needed
              child: Text(
                'Pin Message ...',
                style: TextStyle(
                  fontSize: 12.0,
                  color: AppColors.primaryThreeElementText,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  right: 16.0), // Adjust the padding as needed
              child: Icon(
                Icons.arrow_drop_down, // Replace with the desired icon
                color: AppColors
                    .primaryThreeElementText, // Adjust the icon color as needed
                size: 24.0, // Adjust the icon size as needed
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        controller.goShowPinMessage();
      },
    );
  }

  Widget _pinMessageFullScreen() {
    return GestureDetector(
      onTap: () {

        controller.goShowMorePinMessage(); //เปิดข้อความ detail

      },
      child: Container(
        color: AppColors.primarySecondaryBackground.withOpacity(0.8),
        child: const Padding(
          padding: EdgeInsets.all(16.0), // You can adjust the padding as needed
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'full Pin Message ...',
              style: TextStyle(
                fontSize: 12.0,
                color: AppColors.primaryThreeElementText,
                
              ),
            ),
          ),
        ),
      ),
    );
  }

}
