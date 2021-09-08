import 'package:get/get.dart';
import 'package:iteservice/controllers/controllers.dart';
import 'package:iteservice/controllers/currencyController.dart';

class InitialBinding implements Bindings {
@override
void dependencies() {
    Get.put<FirebaseAuthController>(FirebaseAuthController());
    Get.put<CurrencyController>(CurrencyController());
  }
}