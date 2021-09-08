import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iteservice_dashboard/controllers/firebaseAuthController.dart';

class AuthController extends GetxController {
  // For sign in
  var signInFormKey = GlobalKey<FormState>().obs;
  var email1 = TextEditingController(text: "074bcsit012.bijay@scst.edu.np").obs;
  var password1 = TextEditingController().obs;

  Future<void> signIn() async {
    if (signInFormKey.value.currentState!.validate()) {
      await Get.find<FirebaseAuthController>()
          .signIn(email1.value.text, password1.value.text);
      clear();
    }
  }

  // Clear the fields
  clear() {
    password1.value.text = "";
  }
}
