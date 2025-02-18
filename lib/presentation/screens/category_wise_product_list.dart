import 'package:ecommerce/presentation/controllers/product_list_by_category_controller.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:ecommerce/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryWiseProductList extends StatefulWidget {
  const CategoryWiseProductList({super.key, required this.categoryName,required this.categoryId});

  final String categoryName;
  final int categoryId;

  @override
  State<CategoryWiseProductList> createState() => _CategoryWiseProductListState();
}


class _CategoryWiseProductListState extends State<CategoryWiseProductList> {

  @override
  void initState() {
    super.initState();
    ProductListByCategoryController controller=Get.find<ProductListByCategoryController>();
    controller.getProductListByCategory(widget.categoryId);
  }

  @override
  Widget build(BuildContext context) {
    final sizes=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.categoryName),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0,left: 12,right: 12),
              child: GetBuilder<ProductListByCategoryController>(
                builder: (controller) {
                  return RefreshIndicator(
                    onRefresh: ()async{
                      await Get.find<ProductListByCategoryController>().getProductListByCategory(widget.categoryId);
                    },
                    child: Visibility(
                      visible: !controller.inProgress,
                      replacement: const CenterLoader(),
                      child: GridView.builder(
                        itemCount: controller.productListByCategory.length,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          childAspectRatio: 0.7,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          return ProductCard(sizes: sizes, product: controller.productListByCategory[index],);
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
