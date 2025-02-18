import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/models/product_list_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/reviews_list_model.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class ReviewsListController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  List<Review> _reviewsList=[];

  bool get inProgress => _inProgress;
  List<Review> get reviewsList => _reviewsList;
  String get errorMessage => _errorMessage;

  Future<void> getReviewsList(int productId)async{
    _inProgress = true;
    update();

    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.reviewsList(productId));
    if (response.isSuccess) {
      _reviewsList =
          ReviewsList.fromJson(response.responseData).reviewsList ??
              [];
    } else {
      _errorMessage = response.errorMessage ?? '';
    }
    _inProgress = false;
    update();
    return;
  }
}