import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/common/routes/routes.dart';
import 'package:chatty/common/values/colors.dart';

import 'package:chatty/pages/message/controller.dart';
import 'package:chatty/pages/message/widgets/news_message_list.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_icon_class/font_awesome_icon_class.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagePage extends GetView<MessageController> {
  const MessagePage({Key? key}) : super(key: key);


  Widget _headBar() {
    return Center(
      child: Container(
        width: 320.w,
        height: 44.w,
        margin: EdgeInsets.only(bottom: 20.h, top: 20.h),
        child: Row(
          children: [
            Stack(
              children: [
                GestureDetector(
                  child: Container(
                    width: 44.h,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: AppColors.primarySecondaryBackground,
                      borderRadius: BorderRadius.all(Radius.circular(22.h)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 2,
                          offset: const Offset(0, 1),
                        )
                      ],
                    ),
                    child: controller.state.head_detail.value.avatar == null
                        ? const Image(
                            image:
                                AssetImage('assets/images/account_header.png'),
                          )
                        : CachedNetworkImage(
                            imageUrl:
                                controller.state.head_detail.value.avatar!,
                            height: 44.w,
                            width: 44.w,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(22.w)),
                                image: DecorationImage(
                                    image: imageProvider, fit: BoxFit.fill),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Image(
                                image: AssetImage(
                                    'assets/images/account_header.png')),
                          ),
                  ),
                  onTap: () {
                    controller.goProfile();
                  },
                ),
                Positioned(
                  bottom: 5.w,
                  right: 0.w,
                  height: 14.w,
                  child: Container(
                    width: 14.w,
                    height: 14.w,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2.w,
                        color: AppColors.primaryElementText,
                      ),
                      color: AppColors.primaryElementStatus,
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.w),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget _headTabs() {
    return Center(
        child: Container(
            width: 320.w,
            height: 48.h,
            margin: EdgeInsets.only(bottom: 0.h),
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppColors.primarySecondaryBackground,
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                    child: Container(
                      width: 150.w,
                      height: 40.h,
                      margin: EdgeInsets.only(bottom: 0.h),
                      padding: EdgeInsets.all(0.h),
                      decoration: controller.state.tabStatus.value
                          ? BoxDecoration(
                        color: AppColors.primaryBackground,
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      )
                          : BoxDecoration(),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "ข่าวประกาศ",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryThreeElementText,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      //controller.goTabStatus();
                    }),
                /*GestureDetector(
                    child: Container(
                      width: 150.w,
                      height: 40.h,
                      margin: EdgeInsets.only(bottom: 0.h),
                      padding: EdgeInsets.all(0.h),
                      decoration: controller.state.tabStatus.value
                          ? BoxDecoration()
                          : BoxDecoration(
                        color: AppColors.primaryBackground,
                        borderRadius:
                        BorderRadius.all(Radius.circular(5)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 3,
                            offset: Offset(
                                0, 2), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Text(
                              "Call",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryText,
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      controller.goTabStatus();
                    })*/
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Obx(
          () =>
              SafeArea(
            child: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      pinned: true,
                      title: _headBar(),
                    ),
                   SliverPadding(
                       padding: EdgeInsets.symmetric(
                         vertical: 0.w,
                         horizontal: 0.w,
                       ),
                     sliver: SliverToBoxAdapter(
                       child: _headTabs(),
                     ),
                   ) ,  // เอาไว้แสดง tab call และ chat

                    SliverPadding(
                      padding: EdgeInsets.symmetric(
                        vertical: 0.w,
                        horizontal: 0.w,
                      ),
                      sliver: SliverToBoxAdapter(

                        child: NewsMessageList(),
                      ),
                    ) ,
                  ],
                ),



                //BottomNavigationBar(items: items),

                Positioned(
                  right: 20.w,
                  bottom: 70.w,
                  height: 50.w,
                  width: 50.w,
                  child: GestureDetector(
                    child: Container(
                      height: 50.w,
                      width: 50.w,
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: AppColors.primaryElement,
                        borderRadius: BorderRadius.all(
                          Radius.circular(40.w),
                        ),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(1, 1))
                        ],
                      ),
                      //child: Image.asset('assets/icons/contact.png'),
                      child: Icon(
                        FontAwesomeIcons.comments,  // Use FontAwesomeIcons to access the icon
                        color: Colors.white,  // Set the icon color as needed
                        size: 30,  // Set the icon size as needed
                      ),
                    ),
                    onTap: () {
                      Get.toNamed(AppRoutes.Contact);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

    );
  }
}
