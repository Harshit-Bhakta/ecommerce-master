import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/models/product_details_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:ecommerce/presentation/controllers/wishlist_controller.dart';
import 'package:get/get.dart';

class ProductDetailsController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  ProductDetails _productDetails=ProductDetails();

  bool get inProgress => _inProgress;
  ProductDetails get productDetails => _productDetails;
  String get errorMessage => _errorMessage;


  Future<void> getProductDetails(int id)async{
    _inProgress=true;
    update();
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.productDetails(id));
    if(response.isSuccess){
      List<ProductDetails>? productWrap=ProductDetailsWrapper.fromJson(response.responseData).productDetailsWrap;
      if(productWrap!.isNotEmpty){
        _productDetails = productWrap[0];
      }else{
        _productDetails=ProductDetails(
            img1: "https://photo.teamrabbil.com/images/2023/08/15/macbooks-2048px-2349.md.jpeg",
            img2: "https://photo.teamrabbil.com/images/2023/09/23/Group-1.png",
            img3: "https://photo.teamrabbil.com/images/2023/09/23/Group-2.png",
            img4: "https://photo.teamrabbil.com/images/2023/09/23/Group-3.png",
            size: 'S,M,L,XL',
            color: 'Red,Green,White,Blue',
            des: 'Short descroption will be placed here. this is just and place holding text',
            product: Product(
              star: 4.7,
              title: 'New Year Shoe',
            )
        );
      }
    }else{
      _errorMessage=response.errorMessage ?? '';
    }

    await Get.find<WishListController>().isWishListedCheck(id);
    _inProgress=false;
    update();
    return;
  }
}