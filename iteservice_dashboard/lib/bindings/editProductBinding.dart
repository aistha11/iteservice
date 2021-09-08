import 'package:get/get.dart';
import 'package:iteservice_dashboard/controllers/controllers.dart';

class EditProducBinding implements Bindings {
@override
void dependencies() {
  Get.put<EditProductController>(EditProductController());
  }
}