import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iteservice_dashboard/config/pallete.dart';
import 'package:iteservice_dashboard/controllers/controllers.dart';
import 'package:iteservice_dashboard/models/models.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ProductsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetX<ProductController>(builder: (controller) {
        if(controller.productList.length == 0){
          return Center(child: Text("No products"),);
        }
        return SafeArea(
          child: ListView.builder(
            itemCount: controller.productList.length,
            itemBuilder: (_, i) {
              Product product = controller.productList[i];
              return ProductListTile(product: product,);
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed("/addProduct");
          },
          child: Icon(Icons.add),
          backgroundColor: Pallete.primaryCol,
          tooltip: "Add New Product"),
    );
  }
}

class ProductListTile extends StatelessWidget {
  const ProductListTile({Key? key, required this.product}) : super(key: key);
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<ProductController>(builder: (controller) {
        return Slidable(
          key: key,
          actionPane: SlidableStrechActionPane(),
          secondaryActions: [
            IconSlideAction(
              caption: 'Edit',
              color: Colors.blue,
              icon: Icons.edit,
              onTap: () {
                Get.toNamed("/editProduct/${product.id}");
              },
            ),
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () {
                Get.find<ProductController>().deleteProduct(product.id!);
              },
            ),
          ],
          child: ListTile(
            isThreeLine: true,
            leading: CachedNetworkImage(
              imageUrl: product.imageUrl,
              width: 100,
              height: 150,
              fit: BoxFit.cover,
            ),
            title: Text(
              "${product.title}",
              maxLines: 2,
            ),
            subtitle: Text("${product.description}"),
          ),
        );
      }),
    );
  }
}
