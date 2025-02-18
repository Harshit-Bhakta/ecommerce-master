
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/presentation/controllers/wishlist_controller.dart';
import 'package:ecommerce/presentation/screens/product_details_screen.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:ecommerce/presentation/widgets/CachedImage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.sizes, required this.product});

  final Size sizes;
  final Product product;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.find<WishListController>().isWishListedCheck(widget.product.id??0);
        Get.to(() => ProductDetailsScreen(
              productId: widget.product.id ?? 1,
            ));
      },
      child: Card(
        elevation: 4,
        surfaceTintColor: Colors.transparent,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: ProductImage(
                  imageLink: widget.product.image ??
                      "https:\/\/photo.teamrabbil.com\/images\/2023\/04\/04\/product.png"),
            ),
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductTitle(productName: widget.product.title ?? 'Title'),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: widget.sizes.width * 0.01),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ProductPrice(
                            price: double.parse(widget.product.price ?? '100')),
                        Row(
                          children: [
                            ProductRating(
                                rating:
                                    widget.product.star?.toStringAsFixed(1) ?? '4.7'),
                            SizedBox(
                              width: widget.sizes.width * 0.01,
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProductRating extends StatelessWidget {
  const ProductRating({
    super.key,
    required this.rating,
  });

  final String rating;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.star,
          color: Colors.yellowAccent,
          size: 15,
        ),
        Text(
          rating,
          style: const TextStyle(color: Colors.black54, fontSize: 13),
        ),
      ],
    );
  }
}

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Text(
      '\$${price.toStringAsFixed(0)}',
      style: const TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.w700,
          fontSize: 14),
    );
  }
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
    required this.productName,
  });

  final String productName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Text(
        productName,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(
            fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black54),
      ),
    );
  }
}

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.imageLink,
  });

  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.1),
        ),
        child: CachedImage(
          url: imageLink,
        ));
  }
}
