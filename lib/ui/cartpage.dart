import 'package:ecommerceapp/data/product_entry.dart';
import 'package:ecommerceapp/productcontroller/cartcontroller.dart';
import 'package:ecommerceapp/productcontroller/paymentcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());
    final paymentController = Get.put(PaymentController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Cart Page'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () {
                return cartController.cart.isEmpty
                    ? Center(
                        child: Text(
                          'No Items In The Cart Currently',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartController.cart.length,
                        itemBuilder: (context, index) {
                          final productname =
                              cartController.cart.keys.elementAt(index);
                          final quantity =
                              cartController.cart[productname] ?? 0;
                          final product = productdata.firstWhere(
                            (element) => element.productname == productname,
                          );

                          return Padding(
                            padding: EdgeInsets.all(0),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10),
                                        topRight: Radius.circular(10),
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      productname,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Quantity: $quantity',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black87,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: quantity > 0
                                                  ? () {
                                                      cartController
                                                          .removefromcart(
                                                              product);
                                                    }
                                                  : null,
                                              label: Text('Remove From Cart'),
                                              icon: Icon(
                                                  Icons.remove_shopping_cart),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                cartController
                                                    .addtocart(product);
                                              },
                                              label: Text('Add To Cart'),
                                              icon:
                                                  Icon(Icons.add_shopping_cart),
                                              style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
              },
            ),
          ),
          Obx(() {
            return Container(
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Total Price: ${cartController.totalcost.value}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }),
          cartController.totalcost.value == 0
              ? Container()
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      paymentController.openCheckout();
                    },
                    child: Text('Proceed to Pay'),
                  ),
                ),
        ],
      ),
    );
  }
}
