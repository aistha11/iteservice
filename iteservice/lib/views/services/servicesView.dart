import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:iteservice/bindings/bindings.dart';
import 'package:iteservice/config/currenciesJson.dart';
import 'package:iteservice/config/pallete.dart';
import 'package:iteservice/controllers/controllers.dart';
import 'package:iteservice/utilities/utls.dart';
import 'package:iteservice/views/chat/chatMessageView.dart';
import 'package:iteservice/widgets/widgets.dart';

class ServicesView extends GetView<ServicesController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      drawer: MyDrawer(),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            controller.openDrawer();
          },
          icon: Icon(
            Icons.menu,
          ),
        ),
        title: Text(
          'All Services',
          style: TextStyle(
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        actions: [
          // IconButton(
          //   onPressed: () {
          //     String email = Get.find<FirebaseAuthController>().user!.email!;
          //     String username = Utils.getUsername(email);
          //     Get.to(() => ChatMessageView(),
          //         binding: ChatsBinding(), arguments: {'id': "$username"});
          //   },
          //   icon: Icon(
          //     FontAwesomeIcons.facebookMessenger,
          //     color: Colors.black,
          //   ),
          // ),
          SizedBox(
            width: 5,
          ),
          GetX<CurrencyController>(builder: (controller) {
            return CurrencyDropDown(
              items: CurrenciesJson.currencies.keys.toList(),
              value: controller.to.value,
              onChange: (val) {
                controller.changeCurrency(val);
              },
            );
          }),
        ],
        bottom: _buildBottomBar(),
      ),
      body: Container(
        child: GetX<ProductController>(builder: (productController) {
          return StaggeredGridView.countBuilder(
            crossAxisCount: 4,
            itemCount: productController.productList.length,
            itemBuilder: (_, i) {
              return StaggeredProductTile(
                key: Key(productController.productList[i].id!),
                product: productController.productList[i],
              );
            },
            staggeredTileBuilder: (i) {
              return StaggeredTile.fit(2);
            },
            mainAxisSpacing: 2.0,
            crossAxisSpacing: 2.0,
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.backgroundColor,
        onPressed: () {
          String email = Get.find<FirebaseAuthController>().user!.email!;
          String username = Utils.getUsername(email);
          Get.to(() => ChatMessageView(),
              binding: ChatsBinding(), arguments: {'id': "$username"});
        },
        child: Icon(
          FontAwesomeIcons.facebookMessenger,
          color: Colors.blue,
          size: 34,
        ),
      ),
    );
  }

  PreferredSize _buildBottomBar() {
    return PreferredSize(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.all(Radius.circular(30)),
          child: GetX<ProductController>(builder: (controller) {
            return TextFormField(
              controller: controller.searchController.value,
              onChanged: (val) {
                controller.setQuery(val);
              },
              decoration: InputDecoration(
                hintText: "Search...",
                border: InputBorder.none,
                suffixIcon: Material(
                  elevation: 2.0,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  child: Icon(Icons.search),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 25, vertical: 13),
              ),
            );
          }),
        ),
      ),
      preferredSize: Size.fromHeight(70.0),
    );
  }
}
