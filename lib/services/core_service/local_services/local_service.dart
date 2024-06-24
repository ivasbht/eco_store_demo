import 'dart:developer';

import 'package:eco_store_demo/const_files/config_file/config_file.dart';
import 'package:eco_store_demo/model/cart_model/cart_model.dart';
import 'package:hive/hive.dart';

mixin LocalService {
  Box? cartBox;

  Future<void> openCartBox() async {
    if (cartBox == null || (!cartBox!.isOpen)) {
      cartBox = await Hive.openBox(ConfigFile.cartBoxName);
      log("Opening Box:${cartBox?.isOpen??"N/A"}");
    } else {
      log("Already Open: ${cartBox?.isOpen??"N/A"}");
      cartBox = await Hive.box(ConfigFile.cartBoxName);
    }
  }

  Future<void> closeCart() async {
    log("Closing Cart");
    return cartBox!.close();
  }

  Future<void> addUpdateCart(CartModel cart) async {
    cartBox!.put(cart.productId.toString(), cart.toMap());
  }

  Future<void> deleteCart(String productId) async {
    await cartBox!.delete(productId);
  }

  List<dynamic> getAllCart() {
    return (cartBox?.values??[]).toList();
  }
}
