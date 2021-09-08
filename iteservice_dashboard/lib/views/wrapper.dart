import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iteservice_dashboard/config/userState.dart';
import 'package:iteservice_dashboard/controllers/controllers.dart';
import 'package:iteservice_dashboard/views/views.dart';

class Wrapper extends GetView<FirebaseAuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status == Status.AUTHENTICATED) {
        return HomeView();
      } else {
        return AuthView();
      }
    });
  }
}