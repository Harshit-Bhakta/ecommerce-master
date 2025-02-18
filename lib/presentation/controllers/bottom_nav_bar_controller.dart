import 'package:ecommerce/presentation/controllers/user_auth_controller.dart';
import 'package:ecommerce/presentation/screens/email_verify_screen.dart';
import 'package:get/get.dart';

class BottomNavBarController extends GetxController{

  int _selectedNavBarItem=0;

  get selectedNavBarItem => _selectedNavBarItem;

  changeSelectedItem(int index){
    if(index>1 && AuthController.accessToken.isEmpty){
      Get.to(() => const EmailVerifyScreen());
    }else{
      _selectedNavBarItem = index;
      update();
    }
  }
}