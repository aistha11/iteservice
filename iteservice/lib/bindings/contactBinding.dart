import 'package:get/get.dart';
import 'package:iteservice/controllers/contactController.dart';

class ContactBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ContactController>(ContactController());
  }
}
