import 'package:ecommerce/presentation/controllers/email_verify_controller.dart';
import 'package:ecommerce/presentation/screens/otp_verify_screen.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:ecommerce/presentation/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/asset_paths.dart';

class EmailVerifyScreen extends StatefulWidget {
  const EmailVerifyScreen({super.key});

  @override
  State<EmailVerifyScreen> createState() => _EmailVerifyScreenState();
}

class _EmailVerifyScreenState extends State<EmailVerifyScreen> {
  final TextEditingController _emailTEController=TextEditingController();
  final GlobalKey<FormState> _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final sizes=MediaQuery.sizeOf(context);
    final textTheme=Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(sizes.height*0.05),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Spacer(),
                Logo(path: AssetPaths.appLogo,scale: sizes.height*0.12,),
                SizedBox(height: sizes.height*0.03,),
                Text('Welcome Back', style: textTheme.titleLarge,),
                SizedBox(height: sizes.height*0.01,),
                Text('Please Enter Your Email Address', style: textTheme.titleSmall,),
                SizedBox(height: sizes.height*0.02,),
                TextFormField(
                  controller: _emailTEController,
                  validator: (value) {
                    if(value==null || value==''){
                      return 'Enter your email';
                    }else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value.trim())){
                      return 'Enter a valid email';
                    }else{
                      return null;
                    }
                  },
                ),
                SizedBox(height: sizes.height*0.02,),
                GetBuilder<EmailVerifyController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                        await controller
                            .emailVerify(_emailTEController.text.trim())
                            .then((isSuccess) {
                          if (isSuccess) {
                            Get.off(() => OTPVerifyScreen(
                                  email: _emailTEController.text.trim(),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  controller.errorMessage,
                                  style: const TextStyle(
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                            );
                          }
                        });
                      }
                    },
                      child: Visibility(
                        visible: !controller.inProgress,
                        replacement: const SizedBox(
                          height: 25,
                          width: 25,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                        child: const Text('Next',),
                      ),
                    );
                  }
                ),
                const Spacer(),
                const Spacer(),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
