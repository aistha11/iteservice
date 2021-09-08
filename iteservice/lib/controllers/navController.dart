import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iteservice/views/views.dart';

class NavController extends GetxController {
  var currentIndex = 0.obs;
  List<Widget> pages = [
    
    ServicesView(),
    CartView(),
    OrderView(),
    // HomeView(),
  ];
  void onPageChange(int index) {
    currentIndex.value = index;
  }
}
