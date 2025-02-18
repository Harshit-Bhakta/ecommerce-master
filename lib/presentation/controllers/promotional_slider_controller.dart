import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/models/promotion_slider_list_model.dart';
import 'package:ecommerce/data/models/promotional_slider_data_model.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class PromotionalSliderController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  List<PromotionalSliderData> _promotionalSliderList=[];

  bool get inProgress => _inProgress;
  List<PromotionalSliderData> get promotionalSliderList => _promotionalSliderList;
  String get errorMessage => _errorMessage;

  Future<void> getPromotionalSliderList()async{
    _inProgress=true;
    update();

    final NetworkResponse response=await NetworkCaller.getRequest(url: Urls.promotionalSliderList);

    if(response.isSuccess){
      _promotionalSliderList=PromotionalSliderListModel.fromJson(response.responseData).promotionalSliderList ?? [];
    }else{
      _errorMessage=response.errorMessage ?? '';
    }

    _inProgress=false;
    update();
    return;
  }
}