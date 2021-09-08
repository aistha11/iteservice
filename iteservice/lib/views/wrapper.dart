import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iteservice/config/userState.dart';
import 'package:iteservice/controllers/controllers.dart';
import 'package:iteservice/views/views.dart';


class Wrapper extends GetView<FirebaseAuthController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.status == Status.AUTHENTICATED) {
        return NavView();
      } else {
        return AuthView();
      }
    });
  }
}