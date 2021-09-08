import 'package:get/get.dart';
import 'package:iteservice/controllers/controllers.dart';

class WrapperBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<NavController>(NavController());
    Get.put<ServicesController>(ServicesController());
    Get.put<ProductController>(ProductController());
  }
}
