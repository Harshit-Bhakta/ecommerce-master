import 'package:ecommerce/presentation/screens/bottom_nav_layout.dart';
import 'package:ecommerce/presentation/screens/complete_profile_screen.dart';
import 'package:ecommerce/presentation/screens/email_verify_screen.dart';
import 'package:ecommerce/presentation/utils/asset_paths.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ecommerce/presentation/widgets/logo.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).whenComplete(() => Get.off(() => BottomNavLayout()));
  }
  @override
  Widget build(BuildContext context) {
    Size sizes=MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Logo(
              path: AssetPaths.appLogo,
              scale: sizes.height*0.2
            ),
            const Spacer(),
            const CircularProgressIndicator(),
            SizedBox(height: sizes.height*0.02,),
            Text(
              'Version: 1.0',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            SizedBox(height: sizes.height*0.03,),
          ],
        ),
      ),
    );
  }
}


