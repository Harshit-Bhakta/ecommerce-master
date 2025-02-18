import 'package:ecommerce/presentation/controllers/reviews_list_controller.dart';
import 'package:ecommerce/presentation/screens/create_review_screen.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key,required this.productId});

  final int productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ReviewsListController>().getReviewsList(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reviews'),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          Get.find<ReviewsListController>().getReviewsList(widget.productId);
        },
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<ReviewsListController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const CenterLoader(),
                    child: ListView.separated(
                      itemCount: controller.reviewsList.length,
                      itemBuilder: (context,index){
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.black.withOpacity(0.08),
                                      radius: 15,
                                      child: const Icon(
                                          Icons.person_outlined,
                                        color: Colors.black54,
                                        size: 25,
                                      ),
                                    ),
                                    const SizedBox(width: 5,),
                                    Text(
                                      controller.reviewsList[index].profile!.cusName!,
                                      style: Theme.of(context).textTheme.titleMedium,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 5,),
                                Text(
                                  controller.reviewsList[index].description!,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context,_){
                        return SizedBox(height: 10,);
                      },
                    ),
                  );
                }
              ),
            ),
            ReviewsCount(productId: widget.productId),
          ],
        ),
      ),
    );
  }
}

class ReviewsCount extends StatelessWidget {
  const ReviewsCount({
    super.key,
    required this.productId
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          color: AppColors.primaryColor.withOpacity(0.15)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GetBuilder<ReviewsListController>(
                  builder: (controller) {
                    return Text(
                      'Reviews (${controller.reviewsList.length})',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w600,
                        color: Colors.black38,
                      ),
                    );
                  }
                ),
              ],
            ),
            CircleAvatar(
              backgroundColor: AppColors.primaryColor,
              child: IconButton(
                onPressed: ()async{
                  bool? added=await Get.to(() => CreateReviewScreen(productId: productId,));
                  if(added==true){
                    Get.showSnackbar(
                        const GetSnackBar(
                          message: 'Review added successfully',
                          duration: Duration(seconds: 2),
                        )
                    );
                    Get.find<ReviewsListController>().getReviewsList(productId);
                  }
                },
                icon: const Icon(
                  Icons.add,
                  size: 25,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
