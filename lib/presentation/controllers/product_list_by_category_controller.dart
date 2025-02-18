import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/models/product_list_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class ProductListByCategoryController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  List<Product> _productListByCategory=[];

  bool get inProgress => _inProgress;
  // bool get isLoaded => _isLoaded;
  List<Product> get productListByCategory => _productListByCategory;
  String get errorMessage => _errorMessage;

  Future<void> getProductListByCategory(int categoryId)async{
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.productListByCategory(categoryId));
    if (response.isSuccess) {
      _productListByCategory =
          ProductList.fromJson(response.responseData).productList ??
              [];
    } else {
      _errorMessage = response.errorMessage ?? '';
    }
    _inProgress = false;
    update();
    return;
  }
}