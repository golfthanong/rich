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
      // appBar: AppBar(
      //   title: Text('GetxBottomBar'),
      //   centerTitle: true,
      // ),
      getPages: AppPages.routes,
      routes: [AppRoutes.SIGN_IN, AppRoutes.EmailLogin, AppRoutes.Message],
      defaultTransition: Transition.noTransition,
      backgroundColor: Colors.grey.shade100,
      bottomBar: <GetBottomBarItem>[
        GetBottomBarItem(
            icon: Icon(Icons.dashboard),
            title: Text('Dashboard'),
            activeColor: Colors.red),
        GetBottomBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            title: Text('Cart'),
            activeColor: Colors.green),
        GetBottomBarItem(
            icon: Icon(Icons.person),
            title: Text('User'),
            activeColor: Colors.blue)
      ],
    );
    /*return Scaffold(
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: _pages.elementAt(controller.state.selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Page 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Page 2',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Page 3',
          ),
        ],
        currentIndex: controller.state.selectedIndex,
        onTap:  (index) {
        // Use a lambda function to pass the index to onItemTapped
        controller.onItemTapped(index);
        },
      ),
      // Container(
      //   width: 360.w,
      //   height: 780.h,
      //   child: _buildPageHeadTitle(controller.title),
      // ),
    );*/  // return เมนู ธรรมดา
  }
}
