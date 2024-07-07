import 'package:ecommerceapp/model/model.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CartController extends GetxController {
  var cart = <String, int>{}.obs;
  var totalcost = 0.obs;

  late Box<dynamic> _cartbox;
  late Box<dynamic> _totalcost;

  @override
  void onInit() {
    super.onInit();
    _initHive();
  }

  Future<void> _initHive() async {
    final appDocumentDir =
        await path_provider.getApplicationDocumentsDirectory();
    Hive.init(appDocumentDir.path);

    _cartbox = await Hive.openBox('cart');
    _totalcost = await Hive.openBox('totalcost');
    _loadcart(); // Load the cart after Hive initialization
  }

  void _loadcart() {
    final storedcart = _cartbox.toMap().cast<String, int>();
    cart.addAll(storedcart);

    final storedtotalcost = _totalcost.get('totalcost', defaultValue: 0);
    totalcost.value = storedtotalcost;
  }

  void addtocart(Product product) {
    if (cart.containsKey(product.productname)) {
      cart[product.productname] = cart[product.productname]! + 1;
    } else {
      cart[product.productname] = 1;
    }
    totalcost.value += product.productprice.toInt();
    _cartbox.put(product.productname, cart[product.productname]);
    _totalcost.put('totalcost', totalcost.value);
  }

  void removefromcart(Product product) {
    if (cart.containsKey(product.productname) &&
        cart[product.productname]! > 0) {
      cart[product.productname] = cart[product.productname]! - 1;
      totalcost.value -= product.productprice.toInt();

      if (cart[product.productname] == 0) {
        cart.remove(product.productname);
        _cartbox.delete(product.productname);
      } else {
        _cartbox.put(product.productname, cart[product.productname]);
      }
      _totalcost.put('totalcost', totalcost.value);
    }
  }
}
