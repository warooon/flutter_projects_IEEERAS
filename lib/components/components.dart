import 'package:ecommerceapp/description/description.dart';
import 'package:ecommerceapp/productcontroller/cartcontroller.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/model/model.dart';
import 'package:get/get.dart';

class ProductView extends StatelessWidget {
  final Product product;

  ProductView({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final cartcontroller = Get.put(CartController());
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: GestureDetector(
        onTap: () {
          Get.to(ProductDescription(products: product));
        },
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: product.productname,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(15.0)),
                  child: Image.asset(
                    product.productimage,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productname,
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      product.productdescription,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      '\$${product.productprice.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      cartcontroller.addtocart(product);
                    },
                    icon: Icon(Icons.add_shopping_cart),
                    label: Text('Add To Cart'),
                    style: ElevatedButton.styleFrom(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      textStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      cartcontroller.removefromcart(product);
                    },
                    icon: Icon(Icons.remove_shopping_cart),
                    label: Text('Remove From Cart'),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        textStyle: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
