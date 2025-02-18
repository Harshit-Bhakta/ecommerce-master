import 'dart:developer';
import 'package:ecommerce/data/models/cart_item_adding_model.dart';
import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class AddToCartController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  int _selectedColorIndex=0;
  int _selectedSizeIndex=0;
  int _quantity=1;
  List<String> _sizesList=[];
  List<String> _colorList=[];


  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;
  int get  selectedColorIndex=> _selectedColorIndex;
  int get  selectedSizeIndex=> _selectedSizeIndex;
  int get  quantity=> _quantity;
  List<String> get  sizeList=> _sizesList;
  List<String> get  colorList=> _colorList;


  colorIndexSetter(int index){
    _selectedColorIndex=index;
    update();
  }
  sizeIndexSetter(int index){
    _selectedSizeIndex=index;
    update();
  }
  quantityIncrease(){
    _quantity+=1;
    update();
  }
  quantityDecrease(){
    if(_quantity>1){
      _quantity -= 1;
      update();
    }
  }
  quantityReset(){
    _quantity=1;
  }
  colorListSetter(List<String> colors){
    _colorList=colors;
  }
  sizeListSetter(List<String> sizes){
    _sizesList=sizes;
  }


  Future<bool> addToCart()async{
    log('triggered');
    _inProgress=true;
    bool isSuccess=false;
    update();
    CartItemToAdd item=CartItemToAdd(
      productId: 2,
      qty: _quantity,
      color: _colorList[_selectedColorIndex],
      size: _sizesList[_selectedSizeIndex],
    );

    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.addToCart,
      body: item.toJson(),
    );
    if(response.isSuccess){
      isSuccess= true;
    }else{
      _errorMessage=response.errorMessage!;
      isSuccess= false;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}