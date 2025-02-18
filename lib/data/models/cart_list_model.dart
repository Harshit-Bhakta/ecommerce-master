import 'package:ecommerce/data/models/cart_item_model.dart';

class CartList {
  String? msg;
  List<CartItem>? cartList;

  CartList({this.msg, this.cartList});

  CartList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      cartList = <CartItem>[];
      json['data'].forEach((v) {
        cartList!.add(CartItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (cartList != null) {
      data['data'] = cartList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
