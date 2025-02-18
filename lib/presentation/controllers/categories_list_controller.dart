import 'package:ecommerce/data/models/category.dart';
import 'package:ecommerce/data/models/category_list_model.dart';
import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CategoriesListController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  List<Category> _categoriesList=[];

  bool get inProgress => _inProgress;
  List<Category> get categoriesList => _categoriesList;
  String get errorMessage => _errorMessage;

  Future<void> getCategoriesList()async{
    _inProgress=true;
    update();

    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.categoriesList);
    if(response.isSuccess){
      _categoriesList=CategoriesList.fromJson(response.responseData).categoriesList ?? [];
    }else{
      _errorMessage=response.errorMessage ?? '';
    }

    _inProgress=false;
    update();
    return;
  }
}