import 'package:ecommerce/data/models/profile_model.dart';
import 'package:ecommerce/presentation/controllers/otp_verify_controller.dart';
import 'package:ecommerce/presentation/controllers/profile_create_controller.dart';
import 'package:ecommerce/presentation/screens/bottom_nav_layout.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:ecommerce/presentation/widgets/logo.dart';
import 'package:ecommerce/presentation/widgets/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/asset_paths.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  final TextEditingController _nameTEController=TextEditingController();
  final TextEditingController _postCodeTEController=TextEditingController();
  final TextEditingController _mobileTEController=TextEditingController();
  final TextEditingController _cityTEController=TextEditingController();
  final TextEditingController _stateTEController=TextEditingController();
  final TextEditingController _shippingAddressTEController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    final sizes=MediaQuery.sizeOf(context);
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 24),
                Logo(scale: sizes.height*0.12, path: AssetPaths.appLogo),
                const SizedBox(height: 16),
                Text('Complete Profile', style: textTheme.titleLarge),
                const SizedBox(height: 4),
                Text('Get started with us by providing your details',
                    style: textTheme.titleSmall),
                const SizedBox(height: 24),
                _buildCompleteProfileForm(),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async{
                    bool status=await Get.find<CreateProfileController>().createProfileData(
                      ProfileModel(
                        cusName: _nameTEController.text.trim(),
                        cusPhone: _mobileTEController.text.trim(),
                        cusState: _stateTEController.text.trim(),
                        cusCity: _cityTEController.text.trim(),
                        cusPostcode: _postCodeTEController.text.trim(),
                        cusAdd: _shippingAddressTEController.text.trim(),
                      )
                    );
                    if(status){
                      Get.back();
                    }else{
                      if(mounted){
                        showSnackBar(
                            context, 'Something went wrong, try again.');
                      }
                    }
                  },
                  child: GetBuilder<CreateProfileController>(
                    builder: (controller) {
                      return Visibility(
                        child: const Text('Next'),
                        visible: !controller.inProgress,
                        replacement: CenterLoader(),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCompleteProfileForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEController,
            decoration: const InputDecoration(hintText: 'Full Name'),
            validator: (value) {
              if(value==null || value==''){
                return 'Empty';
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _mobileTEController,
            decoration: const InputDecoration(hintText: 'Mobile'),
            validator: (value) {
              if(value==null || value==''){
                return 'Empty';
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _stateTEController,
            decoration: const InputDecoration(hintText: 'State'),
            validator: (value) {
              if(value==null || value==''){
                return 'Empty';
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _cityTEController,
            decoration: const InputDecoration(hintText: 'City'),
            validator: (value) {
              if(value==null || value==''){
                return 'Empty';
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _postCodeTEController,
            decoration: const InputDecoration(hintText: 'Post Code'),
            validator: (value) {
              if(value==null || value==''){
                return 'Empty';
              }else{
                return null;
              }
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _shippingAddressTEController,
            maxLines: 3,
            decoration: const InputDecoration(hintText: 'Details Street address'),
            validator: (value) {
              if(value==null || value==''){
                return 'Empty';
              }else{
                return null;
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameTEController.dispose();
    _postCodeTEController.dispose();
    _cityTEController.dispose();
    _stateTEController.dispose();
    _mobileTEController.dispose();
    _shippingAddressTEController.dispose();
    super.dispose();
  }
}
