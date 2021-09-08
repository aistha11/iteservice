import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iteservice/models/models.dart';
import 'package:iteservice/services/services.dart';

class ProductController extends GetxController {

  
  Rx<TextEditingController> searchController = Rx<TextEditingController>(TextEditingController(text: ""));
  
  var query = "".obs;

  final Rx<List<Product>> _productList = Rx<List<Product>>([]);

  List<Product> get productList => _productList.value.where((e){
    return e.title.toLowerCase().contains(query.value.toLowerCase());
  }).toList();

  @override
  void onInit() {
    _productList.bindStream(FirebaseApi.getProducts());
    super.onInit();
  }

  void setQuery(String val){
    query.value = val;
    update();
  }

}