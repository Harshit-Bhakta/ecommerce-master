import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/models/product_list_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class SpecialProductsController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  List<Product> _specialProductsList=[];

  bool get inProgress => _inProgress;
  List<Product> get specialProductsList => _specialProductsList;
  String get errorMessage => _errorMessage;

  Future<void> getSpecialProductsList()async{
    _inProgress=true;
    update();

    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.productListByRemark('special'));
    if(response.isSuccess){
      _specialProductsList=ProductList.fromJson(response.responseData).productList ?? [];
    }else{
      _errorMessage=response.errorMessage ?? '';
    }
    _inProgress=false;
    update();
    return;
  }
}