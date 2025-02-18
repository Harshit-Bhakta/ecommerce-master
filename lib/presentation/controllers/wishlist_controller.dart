
import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/models/wishlist_model.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  bool _isWishListed=false;
  List<WishListItem> _wishList=[];

  bool get inProgress => _inProgress;
  bool get isWishListed => _isWishListed;
  List<WishListItem> get wishList => _wishList;
  String get errorMessage => _errorMessage;

  Future<void> getWishList()async{
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.productWishList);
    if (response.isSuccess) {
      _wishList =
          WishListModel.fromJson(response.responseData).wishList ?? [];
    } else {
      _errorMessage = response.errorMessage
          ?? 'Error retrieving wishlist item';
    }
    _inProgress = false;
    update();
    return;
  }

  Future<void> isWishListedCheck(int id)async{
    _inProgress = true;
    update();
    _isWishListed=false;
    if(_wishList.isEmpty){
      _isWishListed=false;
    }else{
      for(WishListItem item in _wishList){
        if(item.productId==id){
          _isWishListed=true;
        }
      }
    }
    _inProgress = false;
    update();
    return;
  }
}