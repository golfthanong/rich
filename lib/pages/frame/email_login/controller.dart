import 'package:chatty/common/apis/apis.dart';
import 'package:flutter/material.dart';
import 'package:chatty/common/entities/entities.dart';
import 'package:chatty/common/routes/routes.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:chatty/common/store/store.dart';
import 'package:chatty/common/utils/security.dart';
import 'package:chatty/common/values/server.dart';
import 'package:chatty/common/widgets/toast.dart';
import 'index.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';


class EmailLoginController extends GetxController {
  final state = EmailLoginState();
  TextEditingController? EmailEditingController = TextEditingController();
  TextEditingController? PasswordEditingController = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  LoginRequestEntity loginPanelListRequestEntity =
  LoginRequestEntity();

  EmailLoginController();

  // login
  handleEmailLogin() async {
     String emailAddress = state.email.value;
     String password = state.password.value;

     if(emailAddress.isEmpty){
       toastInfo(msg: "Phone Number not empty!");
       return;
     }
     if(password.isEmpty){
       toastInfo(msg: "Password not empty!");
       return;
     }
     //Get.focusScope?.unfocus();
     try {
       loginPanelListRequestEntity.phone = emailAddress;
       loginPanelListRequestEntity.email = password;
       loginPanelListRequestEntity.open_id = emailAddress;
       loginPanelListRequestEntity.avatar = "http://27.254.82.236:8000/assets/icons/therich-online.png";
       loginPanelListRequestEntity.open_id = emailAddress;

       //var result = await UserAPI.Login( params: loginPanelListRequestEntity);
       // final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
       //     email: emailAddress,
       //     password: password
       // );
       asyncPostAllData(loginPanelListRequestEntity);

       // if(credential.user==null) {
       //   toastInfo(msg: "user not login.");
       //   return;
       // }
       // if(!credential.user!.emailVerified){
       //   toastInfo(msg: "please log in to verify your Phone Number");
       //   return;
       // }
       // var user = credential.user;
       // if(user!=null){
       //
       //   String? displayName = user.displayName;
       //   String? email = user.email;
       //   String? id = user.uid;
       //   String? photoUrl = user.photoURL;
       //
       //   LoginRequestEntity loginPageListRequestEntity = new LoginRequestEntity();
       //   loginPageListRequestEntity.avatar = photoUrl;
       //   loginPageListRequestEntity.name = displayName;
       //   loginPageListRequestEntity.email = email;
       //   loginPageListRequestEntity.open_id = id;
       //   loginPageListRequestEntity.type = 1;
       //   asyncPostAllData(loginPageListRequestEntity);
       //
       // }else{
       //   toastInfo(msg: 'login error');
       // }



     } on FirebaseAuthException catch (e) {
       if (e.code == 'user-not-found') {
         print('No user found for that email.');
         toastInfo(msg: "No user found for that email.");
       } else if (e.code == 'wrong-password') {
         print('Wrong password provided for that user.');
         toastInfo(msg: "Wrong password provided for that user.");
       }
     }
  }
  asyncPostAllData(LoginRequestEntity loginRequestEntity) async {
    EasyLoading.show(indicator: CircularProgressIndicator(),maskType: EasyLoadingMaskType.clear,dismissOnTap: true);
    var result = await UserAPI.Login(params: loginRequestEntity);
    print(result);
    // if(result.code==0){
    //   await UserStore.to.saveProfile(result.data!);
    //   Get.offAllNamed(AppRoutes.Message);
    // }else{
    //   toastInfo(msg: 'internet error');
    // }
    // EasyLoading.dismiss();
    //if (result.code == 0) {//ถ้าตอบกลับมาได้ ต้นจะไม่ส่งcodeมา
    if (result.data != null ) {
      await UserStore.to.saveProfile(result.data!);
      EasyLoading.dismiss();
    } else {
      EasyLoading.dismiss();
      toastInfo(msg: 'Internet Error');
    }
    //Get.offAllNamed(AppRoutes.Message);
    Get.offAllNamed(AppRoutes.MainPage);
  }

  @override
  void onReady() {
    super.onReady();

  }

  @override
  void dispose() {
    super.dispose();
  }
}
