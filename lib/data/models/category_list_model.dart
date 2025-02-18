import 'package:ecommerce/data/models/category.dart';
import 'package:ecommerce/data/models/category_list_model.dart';

class CategoriesList {
  String? msg;
  List<Category>? categoriesList;

  CategoriesList({this.msg, this.categoriesList});

  CategoriesList.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      categoriesList = <Category>[];
      json['data'].forEach((v) {
        categoriesList!.add(Category.fromJson(v));
      });
    }
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['msg'] = this.msg;
  //   if (this.categoryList != null) {
  //     data['data'] = this.categoryList!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
