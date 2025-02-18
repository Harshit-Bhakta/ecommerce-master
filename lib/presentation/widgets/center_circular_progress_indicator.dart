import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';

class CenterLoader extends StatelessWidget {
  const CenterLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
      ),
    );
  }
}
