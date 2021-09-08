import 'package:get/get.dart';
import 'package:iteservice_dashboard/models/models.dart';
import 'package:iteservice_dashboard/services/firebaseApi.dart';

class OrderController extends GetxController {

  Rx<List<Order>> _orderList = Rx<List<Order>>([]);


  List<Order> get orderList => _orderList.value;

  @override
  void onInit() {
    
    _orderList.bindStream(FirebaseApi.getAllOrders());
    super.onInit();
  }

  @override
  void dispose() { 
    super.dispose();
  }

  Future<void> changeOrderStatus(Order order) async {
    await FirebaseApi.changeOrderStatus(order);
  }
  Future<void> deleteOrder(Order order) async {
    await FirebaseApi.deleteOrder(order);
  }

  
}