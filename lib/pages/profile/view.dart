import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatty/common/values/colors.dart';
import 'package:chatty/pages/profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfilePage extends GetView<ProfileController> {
  const ProfilePage({Key? key}) : super(key: key);

  AppBar _buildAppbar() {
    return AppBar(
      title: Text(
        'Profile',
        style: TextStyle(
          color: AppColors.primaryText,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildProfilePhoto() {
    return Stack(
      children: [
        Container(
          width: 120.w,
          height: 120.w,
          decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(60.w)),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: const Offset(0, 1)),
            ],
          ),
          child: controller.state.profile_detail.value.avatar!=null?
          CachedNetworkImage(
            imageUrl: controller.state.profile_detail.value.avatar!,
            height: 120.w,
            width: 120.w,
            imageBuilder: (context,imageProvider)=>Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(60.w)),
                image:DecorationImage(
                    image: imageProvider,fit: BoxFit.fill
                ),
              ),
            ),
            errorWidget: (context,url,error)=>const Image(
                image: AssetImage('assets/images/account_header.png')
            ),
          ):
          Image(
            width: 120.w,
            height: 120.h,
            fit: BoxFit.cover,
            image: AssetImage('assets/images/account_header.png'),
          ),
        ),
        Positioned(
          bottom: 0.w,
          right: 0.w,
          height: 35.w,
          child: GestureDetector(
            child: Container(
              height: 35.w,
              width: 35.w,
              padding: EdgeInsets.all(7.w),
              decoration: BoxDecoration(
                color: AppColors.primaryElement,
                borderRadius: BorderRadius.all(Radius.circular(40.w)),
              ),
              child: Image.asset("assets/icons/edit.png"),
            ),
          ),
        )
      ],
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

  Widget _buildLogoutBtn() {
    return GestureDetector(
      child: Container(
        width: 295.w,
        height: 44.h,
        margin: EdgeInsets.only(top: 20.h, bottom: .30.h),
        decoration: BoxDecoration(
          color: AppColors.primarySecondaryElementText,
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
              'Logout',
              style: TextStyle(
                color: AppColors.primaryElementText,
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Get.defaultDialog(
          title: 'Are you sure to logout ?',
          content: Container(),
          onConfirm: () {
            controller.goLogout();
          },
          onCancel: () {},
          textConfirm: 'Confirm',
          textCancel: 'Cancel',
          confirmTextColor: Colors.white,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildProfilePhoto(),
                    _buildCompleteBtn(),
                    _buildLogoutBtn(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
