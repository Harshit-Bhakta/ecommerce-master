import 'package:ecommerce/presentation/controllers/cart_list_controller.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:ecommerce/presentation/widgets/bottom_price_overview_area.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<CartListController>().getCartList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          Get.find<CartListController>().getCartList();
        },
        child: Column(
          children: [
            Expanded(
              child: GetBuilder<CartListController>(
                builder: (controller) {
                  return Visibility(
                    visible: !controller.inProgress,
                    replacement: const CenterLoader(),
                    child: ListView.separated(
                      itemCount: controller.cartList.length,
                      separatorBuilder: (context,_){
                        return const SizedBox(height: 10,);
                      },
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: Image.network(
                                    controller.cartList[index].product!.image!,
                                    height: 100,
                                    width: 100,
                                  ),
                                ),
                                Expanded(
                                  flex: 7,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        controller.cartList[index].product!.title!,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black45,
                                        ),
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                            'Color: ${controller.cartList[index].color},  ',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black45,
                                            ),
                                          ),
                                          Text(
                                            'Size: ${controller.cartList[index].size}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black45,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8),
                                        child: Text(
                                          '\$${controller.cartList[index].price}',
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.primaryColor,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Visibility(
                                        visible: !controller.deleteInProgress && controller.currentIndex!=index,
                                        replacement: const CircularProgressIndicator(
                                          color: AppColors.primaryColor,
                                        ),
                                        child: IconButton(
                                          onPressed: (){
                                            controller.currentIndexSetter(index);
                                            controller.deleteCartItem(controller.cartList[index].productId!);
                                          },
                                          icon: const Icon(
                                            Icons.delete_forever_outlined,
                                            color: Colors.black45,
                                          ),
                                        ),
                                      ),
                                      QuantityStepper(index: index,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              ),
            ),
            GetBuilder<CartListController>(
              builder: (controller) {
                return PriceOverview(isCart: true,price: controller.totalPrice.toString(),);
              }
            ),
          ],
        ),
      ),
    );
  }
}

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,required this.index
  });

  final int index;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartListController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(9),
              child: InkWell(
                onTap: (){
                  if(controller.cartList[index].qty!='1'){
                    controller.changeQuantity(controller.cartList[index].id!, int.parse(controller.cartList[index].qty!)-1);
                  }
                },
                child: Container(
                  height: 21,
                  width: 21,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.primaryColor,
                  ),
                  margin: const EdgeInsets.all(1),
                  child: const Center(
                    child: Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 17,
              child: Text(
                controller.cartList[index].qty!,
                style: const TextStyle(
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(9),
              child: InkWell(
                onTap: (){
                  controller.changeQuantity(controller.cartList[index].id!, int.parse(controller.cartList[index].qty!)+1);
                },
                child: Container(
                  height: 21,
                  width: 21,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: AppColors.primaryColor,
                  ),
                  margin: const EdgeInsets.all(1),
                  child: const Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 17,
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }
    );
  }
}
