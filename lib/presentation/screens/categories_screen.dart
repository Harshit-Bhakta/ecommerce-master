import 'package:ecommerce/presentation/controllers/categories_list_controller.dart';
import 'package:ecommerce/presentation/widgets/category_view.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 16,right: 16),
              child: GetBuilder<CategoriesListController>(
                builder: (controller) {
                  return RefreshIndicator(
                    onRefresh: ()async{
                      await controller.getCategoriesList();
                    },
                    child: Visibility(
                      visible: !controller.inProgress,
                      replacement: const CenterLoader(),
                      child: GridView.builder(
                        itemCount: controller.categoriesList.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.75,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return CategoryView(
                            category: controller.categoriesList[index],
                          );
                        },
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
