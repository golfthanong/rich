import 'package:chatty/common/values/colors.dart';
import 'package:chatty/pages/frame/welcome/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({Key? key}) : super(key: key);

  Widget _buildPageHeadTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 50.h),
      child: Center(
        child: Image.asset('assets/images/app_logo.png'),
      ),
      // Text(
      //   title,
      //   textAlign: TextAlign.center,
      //   style: TextStyle(
      //     color: AppColors.primaryBackground,
      //     fontFamily: "Montserrat",
      //     fontWeight: FontWeight.bold,
      //     fontSize: 45.sp,
      //   ),
      // ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Container(
        width: 360.w,
        height: 780.h,
        child: _buildPageHeadTitle(controller.title),
      ),
    );
  }
}
