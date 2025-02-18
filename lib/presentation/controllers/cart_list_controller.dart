
import 'package:ecommerce/data/models/cart_item_model.dart';
import 'package:ecommerce/data/models/cart_list_model.dart';
import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController{
  bool _inProgress=false;
  bool _deleteInProgress=false;
  String _errorMessage='';
  List<CartItem> _cartList=[];
  int _currentIndex=-1;

  bool get inProgress => _inProgress;
  bool get deleteInProgress => _deleteInProgress;
  int get currentIndex => _currentIndex;
  List<CartItem> get cartList => _cartList;
  String get errorMessage => _errorMessage;

  void currentIndexSetter(int index){
    _currentIndex=index;
  }

  Future<void> getCartList()async{
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.cartList,
    );
    if (response.isSuccess) {
      _cartList =
          CartList.fromJson(response.responseData).cartList ?? [];
    } else {
      _errorMessage = response.errorMessage
          ?? 'Error retrieving wishlist item';
    }
    _inProgress = false;
    update();
    return;
  }

  double get totalPrice{
    double total=0;
    for(CartItem item in _cartList){
      total+= (double.parse(item.qty??'1') * double.parse(item.price??'0'));
    }
    return total;
  }

  void deleteCartItem(int productId)async{
    _deleteInProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteFromCartList(productId),
    );
    if (response.isSuccess) {
      _cartList.removeWhere((element) => element.productId==productId);
    } else {
      _errorMessage = response.errorMessage
          ?? 'Error deleting cart item';
    }
    _deleteInProgress = false;
    _currentIndex=-1;
    update();
    return;
  }

  void changeQuantity(int cartItemId,int quantity){
    _cartList.firstWhere((element) => element.id==cartItemId).qty=quantity.toString();
    update();
  }


}