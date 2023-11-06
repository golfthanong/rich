import 'dart:convert';

import 'package:chatty/common/apis/apis.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/routes/names.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/common/widgets/toast.dart';
import 'package:chatty/common/values/server.dart';
import 'package:chatty/pages/frame/sign_in/state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInController extends GetxController {
  SignInController();

  final state = SignInState();





  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['openid']);

  Future<UserCredential> signInWithApple() async {
    final appleProvider = AppleAuthProvider();
    return await FirebaseAuth.instance.signInWithProvider(appleProvider);
  }

  Future<void> handleSignIn(String type) async {
    //1 : email,2 : google ,3 : facebook , 4 : AppleID , 5 phone
    try {
      if (type == 'phone number') {
        if (kDebugMode) {
          print('... you are logging in with phone number ... ');
        }
      } else if (type == 'google') {
        if (kDebugMode) {
          print('... you are logging in with google ... ');
          var user = await _googleSignIn.signIn();
          if (user != null) {
            String? displayName = user.displayName;
            String email = user.email;
            String id = user.id;
            String photoUrl = user.photoUrl ?? "assets/icons/google.png";
            LoginRequestEntity loginPanelListRequestEntity =
                LoginRequestEntity();
            loginPanelListRequestEntity.avatar = photoUrl;
            loginPanelListRequestEntity.name = displayName;
            loginPanelListRequestEntity.email = email;
            loginPanelListRequestEntity.open_id = id;
            loginPanelListRequestEntity.type = 2;
            //print(jsonEncode(loginPanelListRequestEntity));
            asyncPostAllData(loginPanelListRequestEntity);
          }
        }
      } else if (type == 'facebook') {
        if (kDebugMode) {
          print('... you are logging in with facebook ... ');
        }
      } else if (type == 'apple') {
        if (kDebugMode) {
          print('... you are logging in with Apple ... ');


          var user = await signInWithApple();
          print(user.user);
          if(user.user!=null){

            String displayName = "apple_user";
            String email = "apple@email.com";
            String id = user.user!.uid;
            //String photoUrl = "${SERVER_API_URL}uploads/default.png";
            String photoUrl =  "assets/icons/apple.png";
            print(photoUrl);
            print("apple uid----");
            print(id);
            LoginRequestEntity loginPageListRequestEntity = new LoginRequestEntity();
            loginPageListRequestEntity.avatar = photoUrl;
            loginPageListRequestEntity.name = displayName;
            loginPageListRequestEntity.email = email;
            loginPageListRequestEntity.open_id = id;
            loginPageListRequestEntity.type = 4;
            asyncPostAllData(loginPageListRequestEntity);

          }else{
            toastInfo(msg: 'apple login error');
          }


        }
      }else if (type == 'Email') {
        if (kDebugMode) {
          print('... you are logging in with Email ... ');
          Get.toNamed(AppRoutes.EmailLogin);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('... Error with login ... $e');
      }
    }
  }

  //asyncPostAllData() async {
  asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    //UserStore.to.setIsLogin = true; // set เผื่อทุกครั้งที่เข้ามาจะ login ใหม่
    // print('... let go to message page ...');
    // var response = await HttpUtil().get('api/index');
    // print(response);
    //UserStore.to.setIsLogin = true;
    EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true);
    var result = await UserAPI.Login(params: loginRequestEntity);
    print('yyyyyyyyyyyyyyyyyyyyy');
    print(result.data);
    //if (result.code == 0) {//ถ้าตอบกลับมาได้ ต้นจะไม่ส่งcodeมา
    if (result.data != null ) {
      await UserStore.to.saveProfile(result.data!);
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: 'Internet Error');
    }
    Get.offAllNamed(AppRoutes.Message);
    //Get.offAllNamed(AppRoutes.MainPage);
  }
}
