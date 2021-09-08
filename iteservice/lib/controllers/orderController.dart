import 'package:get/get.dart';
import 'package:iteservice/controllers/controllers.dart';
import 'package:iteservice/models/models.dart';
import 'package:iteservice/services/firebaseApi.dart';
import 'package:iteservice/utilities/utls.dart';


class OrderController extends GetxController {

  Rx<List<Order>> _orderList = Rx<List<Order>>([]);


  List<Order> get orderList => _orderList.value;

  @override
  void onInit() {
    String username = Utils.getUsername(Get.find<FirebaseAuthController>().user!.email!);
    _orderList.bindStream(FirebaseApi.getMyOrders(username));
    super.onInit();
  }

  @override
  void dispose() { 
    super.dispose();
  }

  Future<void> submitOrder(Order order) async {
    await FirebaseApi.createOrder(order);
  }

}