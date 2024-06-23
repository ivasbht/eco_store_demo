import 'package:eco_store_demo/const_files/config_file/config_file.dart';
import 'package:eco_store_demo/model/cart_model/cart_model.dart';
import 'package:hive/hive.dart';

mixin LocalService {
  late Box cartBox;

  Future<void> openCartBox() async {
    if (cartBox.isOpen) {
      cartBox = await Hive.box(ConfigFile.cartBoxName);
    } else {
      cartBox = await Hive.openBox(ConfigFile.cartBoxName);
    }
  }

  Future<void> closeCart() async {
    return cartBox.close();
  }

  Future<void> addUpdateCart(CartModel cart) async {
    cartBox.put(cart.productId, cart.toMap());
  }

  Future<void> deleteCart(CartModel cart) async {
    cartBox.delete(cart.productId);
  }

  Future<dynamic> getAllCart() async {
    return cartBox.values.toList();
  }
}
