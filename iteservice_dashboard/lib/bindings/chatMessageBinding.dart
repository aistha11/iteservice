import 'package:get/get.dart';
import 'package:iteservice_dashboard/controllers/controllers.dart';

class ChatMessageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<ChatMessageController>(ChatMessageController());
  }
}
