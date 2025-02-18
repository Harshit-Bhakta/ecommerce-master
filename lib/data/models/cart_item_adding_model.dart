class CartItemToAdd{
  int? productId;
  String? color;
  String? size;
  int? qty;

  CartItemToAdd({this.productId, this.color, this.size, this.qty});

  CartItemToAdd.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId;
    data['color'] = color;
    data['size'] = size;
    data['qty'] = qty;
    return data;
  }
}