import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iteservice_dashboard/models/models.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:iteservice_dashboard/services/firebaseApi.dart';
import 'package:path/path.dart' as Path;

class EditProductController extends GetxController {
  

  var productId = "".obs;
  var title = TextEditingController().obs;
  var description = TextEditingController().obs;
  var basicPrice = TextEditingController().obs;
  var standardPrice = TextEditingController().obs;
  var premiumPrice = TextEditingController().obs;

  late firebase_storage.Reference ref;

  var productFormKey = GlobalKey<FormState>().obs;

  Rx<List<PickedFile>> pickedImages = Rx<List<PickedFile>>([]);

  var imageUrl = "".obs;

  final picker = ImagePicker();

  var uploading = false.obs;
  var submitting = false.obs;

  @override
  void onInit()async {
    productId.value = Get.parameters['id']!;
    final Product? product = await FirebaseApi.getProductById(productId.value);
    title.value.text = product!.title;
    description.value.text = product.description;
    basicPrice.value.text = product.price.basic.toString();
    standardPrice.value.text = product.price.standard.toString();
    premiumPrice.value.text = product.price.premium.toString();
    imageUrl.value = product.imageUrl;
    super.onInit();
  }

  chooseImage() async {
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      pickedImages.value.add(PickedFile(pickedFile!.path));
    } catch (e) {
      Get.snackbar("Ohh😮😮😮😮", "Image not selected😌😌😌😌");
    }

    update();
  }

  removeImageAt(int index) {
    pickedImages.value.removeAt(index);
    update();
  }

  removeImage(PickedFile file) {
    pickedImages.value.remove(file);
    update();
  }

  removeExistingImage(){
    imageUrl.value = "";
    update();
  }

  Future uploadFile() async {
    uploading.value = true;
    update();

    PickedFile img = pickedImages.value[0];

    ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('product_images/${Path.basename(img.path)}');
    await ref.putFile(File(img.path)).whenComplete(() async {
      await ref.getDownloadURL().then((value) {
        imageUrl.value = value;
      });
    });
    uploading.value = false;
    update();
  }

  Future<void> editProduct() async {
    ConnectivityResult connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.none) {
      Get.snackbar("Check Your Internet Connection!", "Try again later");
    } else {
      if (productFormKey.value.currentState!.validate()) {
        if(pickedImages.value.isNotEmpty){
          uploading.value= true;
          update();
          await uploadFile();
          update();
        }
        submitting.value = true;
        if (imageUrl.value == "") {
          Get.snackbar("Sorry!", "Add at least one image for product.");
        } else {
          Product product = Product(
            id: productId.value,
            title: title.value.text,
            imageUrl: imageUrl.value,
            price: Price(
              basic: double.parse(basicPrice.value.text),
              standard: double.parse(standardPrice.value.text),
              premium: double.parse(premiumPrice.value.text),
            ),
            description: description.value.text,
          );

          FirebaseApi.updateProduct(product).then(
            (value) {
              Get.snackbar(
                "Successfull!!",
                "Your Product is Edited",
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          );
          onClear();
        }
      }
    }
    submitting.value = false;
    update();
  }

  deleteProduct(String id) {
    FirebaseApi.deleteProduct(id);
    update();
  }

  void onClear() {
    title.value.text = "";
    description.value.text = "";
    imageUrl.value = "";
    pickedImages.value = [];
    basicPrice.value.text = "";
    standardPrice.value.text = "";
    premiumPrice.value.text = "";
  }
}
