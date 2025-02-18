import 'package:ecommerce/presentation/controllers/email_verify_controller.dart';
import 'package:ecommerce/presentation/controllers/otp_verify_controller.dart';
import 'package:ecommerce/presentation/controllers/profile_read_controller.dart';
import 'package:ecommerce/presentation/screens/complete_profile_screen.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:ecommerce/presentation/widgets/logo.dart';
import 'package:ecommerce/presentation/widgets/snacbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../utils/asset_paths.dart';

class OTPVerifyScreen extends StatefulWidget {
  const OTPVerifyScreen({super.key,required this.email});

  final String email;

  @override
  State<OTPVerifyScreen> createState() => _OTPVerifyScreenState();
}

class _OTPVerifyScreenState extends State<OTPVerifyScreen> {
  final TextEditingController _otpTEController=TextEditingController();
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
                Text('Enter OTP Code', style: textTheme.titleLarge,),
                SizedBox(height: sizes.height*0.01,),
                Text('A 4 digit OTP code that has been Sent', style: textTheme.titleSmall,),
                SizedBox(height: sizes.height*0.02,),
                _otpTextField(context),
                SizedBox(height: sizes.height*0.02,),
                GetBuilder<OtpVerifyController>(
                  builder: (controller) {
                    return ElevatedButton(
                      onPressed: ()async{
                        if(_formKey.currentState!.validate()){
                          await controller.otpVerify(widget.email, _otpTEController.text.trim()).then((isSuccess) async{
                            ReadProfileController readProfileController=Get.find<ReadProfileController>();
                            if(isSuccess){
                              if(await readProfileController.getProfileData()){
                                Get.back();
                              }else{
                                Get.off(() => const CompleteProfileScreen());
                              }
                            }else{
                              showSnackBar(context, controller.errorMessage);
                            }
                          });
                        }
                      },
                      child: const Text('Next',),
                    );
                  }
                ),
                SizedBox(height: sizes.height*0.04,),
                _resendTimer(textTheme),
                _resendButton(textTheme),
                const Spacer(),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _resendTimer(TextTheme textTheme) {
    return GetBuilder<EmailVerifyController>(
      builder: (controller) {
        return RichText(
          text: TextSpan(
            text: 'This code will expire in ',
            style: textTheme.titleSmall,
            children: [
              TextSpan(
                text: '${controller.time}s',
                style: textTheme.labelSmall,
              ),
            ],
          ),
        );
      }
    );

  }

  Widget _resendButton(TextTheme textTheme) {
    return
      GetBuilder<EmailVerifyController>(
        builder: (controller) {
          return TextButton(
            onPressed: controller.resetButtonEnabled?()async{
              await controller.emailVerify(widget.email).then((value) {
                if(value){
                  showSnackBar(context, 'OTP sent again');
                }else{
                  showSnackBar(context, controller.errorMessage);
                }
              });

            }:null,
            child: Text(
              'Resend Code',
              style: !controller.resetButtonEnabled
                  ?textTheme.titleSmall
                  :const TextStyle(
                color: AppColors.primaryColor,
              ),
            ),

          );
        }
    );
  }

  PinCodeTextField _otpTextField(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.transparent,
        activeColor: AppColors.primaryColor,
        inactiveFillColor: Colors.transparent,
        inactiveColor: Colors.grey,
        selectedFillColor: Colors.transparent
      ),
      enableActiveFill: true,
      controller: _otpTEController,
      beforeTextPaste: (text) {
        return true;
      },
      appContext: context,
    );
  }
  @override
  void dispose() {
    _otpTEController.dispose();
    super.dispose();
  }
}
