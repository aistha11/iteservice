import 'package:get/get.dart';
import 'package:iteservice_dashboard/controllers/controllers.dart';

class InitialBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuthController>(FirebaseAuthController());
  }
}
