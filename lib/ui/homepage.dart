import 'package:ecommerceapp/components/components.dart';
import 'package:ecommerceapp/productcontroller/cartcontroller.dart';
import 'package:ecommerceapp/ui/cartpage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerceapp/data/product_entry.dart';
import 'package:get/get_navigation/src/routes/default_transitions.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  Widget build(BuildContext context) {
    final cartcontroller = Get.put(CartController());
    return Scaffold(
      drawer: Drawer(
          child: Column(children: [
        DrawerHeader(
            child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              'Shopify',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            )
          ],
        )),
      ])),
      appBar: AppBar(
        title: Text('Shopify'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Get.to(() => CartPage(), transition: Transition.rightToLeft);
            },
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: productdata.length,
          itemBuilder: (context, index) {
            return ProductView(product: productdata[index]);
          }),
      floatingActionButton: FloatingActionButton.extended(
          icon: Icon(Icons.shopping_cart),
          onPressed: () {
            // Perform action on button press
          },
          label: Obx(
            () {
              num sum = 0;
              cartcontroller.cart.forEach((k, v) {
                sum = sum + v;
              });
              return Text('Items in Cart:${sum}');
            },
          )),
    );
  }
}
