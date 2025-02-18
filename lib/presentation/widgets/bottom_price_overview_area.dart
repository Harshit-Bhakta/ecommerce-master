import 'package:ecommerce/data/models/cart_item_model.dart';
import 'package:ecommerce/presentation/controllers/add_to_cart_controller.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PriceOverview extends StatelessWidget {
  final bool isCart;
  final String price;
  const PriceOverview({
    super.key,required this.isCart,this.price='1000'
  });

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
              children: [
                Text(
                  !isCart?'Price':'Total Price',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight:
                    FontWeight.w600,
                    color: Colors.black38,
                  ),
                ),
                Text(
                  '\$$price',
                  style: const TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 18
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 140,
              height: 45,
              child: GetBuilder<AddToCartController>(
                builder: (addToCartController) {
                  return ElevatedButton(
                    onPressed: ()async{
                      if(isCart){

                      }else{
                        await addToCartController.addToCart();
                      }
                    },
                    child: Visibility(
                      visible: !addToCartController.inProgress,
                      replacement: const CenterLoader(),
                      child: Text(
                        !isCart?'Add To Cart':'Checkout',
                        style: const TextStyle(
                          color: Colors.white,

                        ),
                      ),
                    ),
                  );
                }
              ),
            )
          ],
        ),
      ),
    );
  }
}
