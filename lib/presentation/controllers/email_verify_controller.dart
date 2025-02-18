import 'dart:async';

import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class EmailVerifyController extends GetxController{
  bool _inProgress=false;
  String _errorMessage='';
  int _time=10;
  bool _resetButtonEnabled=false;


  bool get inProgress => _inProgress;
  bool get resetButtonEnabled => _resetButtonEnabled;
  int get time => _time;
  String get errorMessage => _errorMessage;


  Future<bool> emailVerify(String email)async{
    _inProgress=true;
    bool isSuccess=false;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.emailVerify(email));
    if(response.isSuccess){
      isSuccess= true;
      startTimer();
    }else{
      _errorMessage=response.errorMessage!;
      isSuccess= false;
    }

    _inProgress=false;
    update();
    return isSuccess;
  }

  startTimer(){
    _time=10;
    _resetButtonEnabled=false;
    update();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if(_time>0){
        _time--;
        update();
        if(_time==0){
          _resetButtonEnabled=true;
        }
      }else{
        timer.cancel();
        _resetButtonEnabled=true;
        update();
      }
    });
  }
}