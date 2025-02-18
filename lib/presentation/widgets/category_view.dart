import 'package:ecommerce/data/models/category.dart';
import 'package:ecommerce/presentation/screens/category_wise_product_list.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:ecommerce/presentation/widgets/CachedImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({
    super.key,
    required this.category,
  });

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: (){
            Get.to(() => CategoryWiseProductList(categoryName: category.categoryName!,categoryId: category.id!,));
          },
          child: Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10)
            ),
            child: CachedImage(
              url: category.categoryImg!,
            ),
          ),
        ),
        const SizedBox(height: 10,),
        Text(
          category.categoryName!,
          style: const TextStyle(
            color: AppColors.primaryColor,
          ),
        ),
      ],
    );
  }
}
