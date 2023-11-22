import 'package:chatty/common/values/colors.dart';

import 'package:chatty/pages/frame/sign_in/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class SignInPage extends GetView<SignInController> {
  const SignInPage({Key? key}) : super(key: key);

  Widget _buildLogo() {
    return Container(
      margin: EdgeInsets.only(top: 50.h, bottom: 20.h),
      child: Center(
      child: Image.asset('assets/images/app_logo.png'),
      // Text(
      //   'The Rich Chat .',
      //   textAlign: TextAlign.center,
      //   style: TextStyle(
      //     color: AppColors.primaryText,
      //     fontWeight: FontWeight.bold,
      //     fontSize: 34.sp,
      //   ),
      // ),
      ),
    );
  }

  Widget _buildthirdPartyLogin(String loginType, String pathFile) {
    return GestureDetector(
      child: Container(
        width: 295.w,
        height: 44.h,

        padding: EdgeInsets.all(10.h),
        margin: EdgeInsets.only(bottom: 15.h),
        decoration: BoxDecoration(
          color: AppColors.primarySecondaryBackground,
          borderRadius: const BorderRadius.all(
            Radius.circular(5),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: pathFile == ''
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [
            pathFile == ''
                ? Container()
                : Container(
                    //Container logo google
                    padding: EdgeInsets.only(left: 40.w, right: 30.w),
                    child: Image.asset('assets/icons/$pathFile.png'),
                  ),
            Container(
              //Container logo google
              //padding: EdgeInsets.only(left: 40.w, right: 30.w),
              child: Text(
                'Sign in with $loginType',
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
         print("... sign up from here  third party $loginType...");
         loginType == 'Google'?controller.handleSignIn('google'):
         controller.handleSignIn('Email');
         //controller.handleSignIn('google');
      },
    );
  }

  Widget _buildLoginBtn() {
    return GestureDetector(
        child: Container(
          width: 295.w,
          height: 44.h,
          margin: EdgeInsets.only(top:60.h,bottom: 30.h),
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            color: AppColors.primaryElement,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "The Rich Online Member",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryElementText,
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: () {
          controller.handleSignIn('Email');
        });
  }

  Widget _buildThirdPartyAppleLogin() {
    return GestureDetector(
        child: Container(
          width: 295.w,
          height: 44.h,
          margin: EdgeInsets.only(bottom: 15.h),
          padding: EdgeInsets.all(10.h),
          decoration: BoxDecoration(
            color: AppColors.primarySecondaryBackground,
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(left: 40.w, right: 30.w),
                  child: Image.asset("assets/icons/apple.png")),
              Container(
                child: Text(
                  "Sign in with Apple",
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
          controller.handleSignIn("apple");
        });
  }

  Widget _buildOrWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20.h, bottom: 35.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              indent: 50,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
          const Text(
            '  or  ',
          ),
          Expanded(
            child: Divider(
              endIndent: 50,
              height: 2.h,
              color: AppColors.primarySecondaryElementText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignUpWidget() {
    return GestureDetector(
      child: Column(
        children: [
          Text(
            'Already have an account',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.primaryText,
              fontWeight: FontWeight.normal,
              fontSize: 12.sp,
            ),
          ),
          GestureDetector(
            child: Text(
              'Sign up here',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.secondaryElementText,
                fontWeight: FontWeight.normal,
                fontSize: 12.sp,
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        print("... sign up from here ...");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: transparentAppBar(),
      backgroundColor: AppColors.primaryBackground,
      body: Center(
        child: Column(
          children: [
            _buildLogo(),
            _buildthirdPartyLogin("Google", "google"),
            // _buildthirdPartyLogin("Facebook", "facebook"),
            //_buildthirdPartyLogin("Apple", "apple"),
            //_buildThirdPartyAppleLogin(),
            _buildOrWidget(),
            //_buildLoginBtn(),

            _buildthirdPartyLogin("The Rich Online Member", ""),
            SizedBox(
              height: 35.h,
            ),
            //_buildSignUpWidget(),
          ],
        ),
      ),
    );
  } // signin เก่า



}
