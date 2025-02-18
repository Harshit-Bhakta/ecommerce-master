import 'package:ecommerce/presentation/controllers/wishlist_controller.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:ecommerce/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<WishListController>().getWishList();
  }
  @override
  Widget build(BuildContext context) {
    final sizes=MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('WishList'),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await Get.find<WishListController>().getWishList();
        },
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0,left: 16,right: 16),
                child: GetBuilder<WishListController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: const CenterLoader(),
                      child: RefreshIndicator(
                        onRefresh: ()async{
                          await Get.find<WishListController>().getWishList();
                        },
                        child: GridView.builder(
                          itemCount: controller.wishList.length,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 8,
                            childAspectRatio: 0.73,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (context, index) {
                            return ProductCard(sizes: sizes, product: controller.wishList[index].product!,);
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
      ),
    );
  }
}
