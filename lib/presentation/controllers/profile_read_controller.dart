import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/models/product_details_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/profile_model.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  ProfileModel? _profileModel;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;


  Future<bool> getProfileData()async{
    _inProgress=true;
    bool isSuccess=false;
    update();
    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.readProfile);
    if(response.isSuccess){
      if(response.responseData['data']==null){
        isSuccess=false;
      }else{
        isSuccess=true;
        _profileModel=ProfileModelWrapper.fromJson(response.responseData).profileModel;
      }
    }else{
      isSuccess=false;
      _errorMessage=response.errorMessage ?? '';
    }

    _inProgress=false;
    update();
    return isSuccess;
  }
}