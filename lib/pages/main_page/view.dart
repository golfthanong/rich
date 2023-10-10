import 'package:chatty/common/values/colors.dart';
import 'package:chatty/pages/main_page/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';



class MainPagePage extends GetView<MainPageController> {
  const MainPagePage({Key? key}) : super(key: key);
  static const List<Widget> _pages = <Widget>[
    // Add your pages or sections here
    Text('Page 1'),
    Text('Page 2'),
    Text('Page 3'),
  ];

  Widget _buildPageHeadTitle(String title) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
