import 'package:ecommerceapp/productcontroller/cartcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentController extends GetxController {
  late Razorpay razorpay;
  final cartcontroller = Get.put(CartController());

  @override
  void onInit() {
    super.onInit();
    razorpay = Razorpay();
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    razorpay.clear();
    super.onClose();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_GcZZFDPP0jHtC4',
      'amount': cartcontroller.totalcost.value * 100, // Amount in paise
      'name': 'PaymentSection',
      'description': "Product Payment",
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'}
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print("Error: $e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar("Success", "Payment has been successful!!",
        backgroundColor: Colors.green);
    // Handle post-payment success logic here, e.g., clearing the cart
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar("Failure", "Payment has failed!!",
        backgroundColor: Colors.red);
    // Handle payment failure logic here, e.g., logging or retrying
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar("Wallet", "External Wallet selected!",
        backgroundColor: Colors.blue);
    // Handle external wallet logic here, if necessary
  }
}
