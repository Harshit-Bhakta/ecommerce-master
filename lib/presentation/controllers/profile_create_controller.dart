import 'package:ecommerce/data/models/network_reponse.dart';
import 'package:ecommerce/data/models/product_details_model.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/profile_model.dart';
import 'package:ecommerce/data/network_caller/network_caller.dart';
import 'package:ecommerce/data/utils/urls.dart';
import 'package:get/get.dart';

class CreateProfileController extends GetxController {
  bool _inProgress = false;
  String _errorMessage = '';

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage;

  Future<bool> createProfileData(ProfileModel profileData) async {
    _inProgress = true;
    bool isSuccess = false;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createProfile,
      body: profileData.toJson(),
    );
    if (response.isSuccess) {
      isSuccess = true;
    } else {
      isSuccess=false;
      _errorMessage = response.errorMessage ?? '';
    }

    _inProgress = false;
    update();
    return isSuccess;
  }
}
