import 'dart:developer';

import 'package:ecommerce/data/models/cart_item_model.dart';
import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:ecommerce/presentation/controllers/wishlist_controller.dart';
import 'package:get/get.dart';

class AddOrRemoveWishListController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';


  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;



  Future<bool> addToWishList(int id)async{
    _inProgress=true;
    bool isSuccess=false;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.addToWishList(id),
    );
    if(response.isSuccess){
      isSuccess= true;
    }else{
      _errorMessage=response.errorMessage!;
      isSuccess= false;
    }
    _inProgress=false;
    await Get.find<WishListController>().getWishList().whenComplete(() => update());
    return isSuccess;
  }

  Future<bool> removeFromWishList(int id)async{
    _inProgress=true;
    bool isSuccess=false;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteFromWishList(id),
    );
    if(response.isSuccess){
      isSuccess= true;
    }else{
      _errorMessage=response.errorMessage!;
      isSuccess= false;
    }
    _inProgress=false;
    await Get.find<WishListController>().getWishList().whenComplete(() => update());
    return isSuccess;
  }
}