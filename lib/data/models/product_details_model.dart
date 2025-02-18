import 'package:ecommerce/data/models/product_model.dart';

class ProductDetailsWrapper {
  String? msg;
  List<ProductDetails>? productDetailsWrap;

  ProductDetailsWrapper({this.msg, this.productDetailsWrap});

  ProductDetailsWrapper.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productDetailsWrap = <ProductDetails>[];
      json['data'].forEach((v) {
        productDetailsWrap!.add(ProductDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['msg'] = msg;
    if (productDetailsWrap != null) {
      data['data'] = productDetailsWrap!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductDetails {
  int? id;
  String? img1;
  String? img2;
  String? img3;
  String? img4;
  String? des;
  String? color;
  String? size;
  int? productId;
  String? createdAt;
  String? updatedAt;
  Product? product;

  ProductDetails(
      {this.id,
        this.img1,
        this.img2,
        this.img3,
        this.img4,
        this.des,
        this.color,
        this.size,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.product});

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    img1 = json['img1']??'https://photo.teamrabbil.com/images/2023/09/23/Group-1.png';
    img2 = json['img2']??'https://photo.teamrabbil.com/images/2023/09/23/Group-1.png';
    img3 = json['img3']??'https://photo.teamrabbil.com/images/2023/09/23/Group-1.png';
    img4 = json['img4']??'https://photo.teamrabbil.com/images/2023/09/23/Group-1.png';
    des = json['des']??'Short descroption will be placed here. this is just and place holding text';
    color = json['color']??'Red,Green,Blue';
    size = json['size']??'M,L,XL';
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null
        ? Product.fromJson(json['product'])
        : Product(
          star: 4.7,
          title: 'New Year Shoe',
        );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img1'] = img1;
    data['img2'] = img2;
    data['img3'] = img3;
    data['img4'] = img4;
    data['des'] = des;
    data['color'] = color;
    data['size'] = size;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    return data;
  }
}

