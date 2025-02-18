import 'package:ecommerce/presentation/controllers/add_to_cart_controller.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuantityStepper extends StatelessWidget {
  const QuantityStepper({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddToCartController>(
      builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(9),
              child: InkWell(
                onTap: (){
                  controller.quantityDecrease();
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
                controller.quantity.toString(),
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
                  controller.quantityIncrease();
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