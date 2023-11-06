import 'package:chatty/common/routes/names.dart';
import 'package:chatty/pages/main_page/state.dart';
import 'package:get/get.dart';

class MainPageController extends GetxController {
  MainPageController();
  final title = "TSW Chat .";
  final state = MainPageState();


   // onItemTapped(int index) {
   //  print('index: $index');
   //  if (index == 2) {
   //    // Navigate to MainPage using GetX route
   //    Get.offAllNamed(AppRoutes.MainPage); // Replace AppRoutes.MainPage with your actual route name
   //  }
   //  }



//   @override
//   void onReady() {
//     super.onReady();
//     Future.delayed(
//         const Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.Message));
//   }
 }