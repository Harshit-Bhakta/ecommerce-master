import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:ecommerce/presentation/controllers/user_auth_controller.dart';
import 'package:ecommerce/presentation/screens/otp_verify_screen.dart';
import 'package:get/get.dart';

class CreateReviewController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';


  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;


  Future<bool> createReview(Map<String,dynamic> body)async{
    _inProgress=true;
    bool isSuccess=false;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createReview,
      body: body,
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