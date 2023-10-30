import 'package:chatty/common/routes/names.dart';
import 'package:chatty/pages/shopping/state.dart';
import 'package:get/get.dart';

class ShoppingController extends GetxController {
  ShoppingController();
  final title = "TSW Chat .";
  final state = ShoppingState();

  @override
  void onReady() {
    super.onReady();
    //Future.delayed(
        //const Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.Message));
        //const Duration(seconds: 3), () => Get.offAllNamed(AppRoutes.MainPage));
  }
}
