import 'package:chatty/common/values/colors.dart';
import 'package:chatty/pages/main_page/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getxbottombar/getxbottombar.dart';

import '../../common/routes/names.dart';
import '../../common/routes/pages.dart';



class MainPagePage extends GetView<MainPageController> {
  const MainPagePage({Key? key}) : super(key: key);


  /*Widget _buildPageHeadTitle(String title) {
    return Container(
      margin: EdgeInsets.only(top: 50.h),
      child: Center(
        child: Image.asset('assets/images/icons-google.png'),
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
  }*/

  @override
  Widget build(BuildContext context) {
    return GetxBottomBarView(

      getPages: AppPages.routes,
      routes: [AppRoutes.Message, AppRoutes.SIGN_IN, AppRoutes.EmailLogin, AppRoutes.Contact],
      defaultTransition: Transition.noTransition,
      backgroundColor: Colors.grey.shade100,
      height: 60.h,
      bottomBar: <GetBottomBarItem>[
        GetBottomBarItem(
            icon: Icon(Icons.home_filled),
            title: Text('Home'),
            activeColor: Colors.red),
        GetBottomBarItem(
            icon: Icon(Icons.backpack_rounded),
            title: Text('Shopping'),
            activeColor: Colors.deepOrangeAccent),
        GetBottomBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            title: Text('Cart'),
            activeColor: Colors.green),
        GetBottomBarItem(
            icon: Icon(Icons.chat),
            title: Text('Chat'),
            activeColor: Colors.blue)
      ],
    );

  }
}
