import 'package:chatty/pages/shopping/controller.dart';
import 'package:get/get.dart';

class ShoppingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ShoppingController>(() => ShoppingController());
  }
}
