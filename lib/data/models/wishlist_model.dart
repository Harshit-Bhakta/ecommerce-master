import 'package:ecommerce/data/models/product_model.dart';

class WishListModel {
  String? msg;
  List<WishListItem>? wishList;

  WishListModel({this.msg, this.wishList});

  WishListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      wishList = <WishListItem>[];
      json['data'].forEach((v) {
        wishList!.add(WishListItem.fromJson(v));
      });
    }
  }
}

class WishListItem {
  int? id;
  int? productId;
  int? userId;
  String? createdAt;
  String? updatedAt;
  Product? product;

  WishListItem(
      {this.id,
        this.productId,
        this.userId,
        this.createdAt,
        this.updatedAt,
        this.product});

  WishListItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}

