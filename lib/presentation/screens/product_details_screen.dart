import 'package:ecommerce/presentation/controllers/add_or_remove_wishlist_controller.dart';
import 'package:ecommerce/presentation/controllers/add_to_cart_controller.dart';
import 'package:ecommerce/presentation/controllers/product_details_controller.dart';
import 'package:ecommerce/presentation/controllers/wishlist_controller.dart';
import 'package:ecommerce/presentation/screens/reviews_screen.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:ecommerce/presentation/widgets/CachedImage.dart';
import 'package:ecommerce/presentation/widgets/bottom_price_overview_area.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:ecommerce/presentation/widgets/product_card.dart';
import 'package:ecommerce/presentation/widgets/quantity_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:get/get.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key,required this.productId});

  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {


  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
    Get.find<AddToCartController>().quantityReset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: Colors.transparent,
      ),
      body: RefreshIndicator(
        onRefresh: ()async{
          await Get.find<ProductDetailsController>().getProductDetails(widget.productId);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProductImagesSlideShow(),
            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                height: 400,
                child: GetBuilder<ProductDetailsController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: const CenterLoader(),
                      child: ListView(
                        children: [
                          Row(
                            children: [
                              ProductTitle(title: controller.productDetails.product?.title??'title'),
                              const Expanded(
                                flex: 2,
                                child: QuantityStepper(),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              ProductRating(rating: controller.productDetails.product?.star.toString()??'4.7'),
                              ReviewsButton(productId: widget.productId),
                              GetBuilder<WishListController>(
                                builder: (controller){
                                  return Visibility(
                                    visible: !controller.inProgress,
                                    replacement: const SizedBox(
                                      height: 10,
                                      width: 10,
                                      child: CenterLoader()
                                    ),
                                    child: ProductWishlisted(
                                      productId: widget.productId,
                                      isWishListed: controller.isWishListed,
                                    ),
                                  );
                                }
                              ),
                            ],
                          ),
                          const SectionHeader(title: 'Color'),
                          ColorSelector(colors: controller.productDetails.color??'Red,Green,White'),
                          const SizedBox(height: 10,),
                          const SectionHeader(title: 'Size'),
                          SizeSelector(sizes: controller.productDetails.size??'S,M,L,XL'),
                          const SizedBox(height: 10,),
                          const SectionHeader(title: 'Description'),
                          Text(
                            controller.productDetails.des
                            ??'Short descroption will be placed here. this is just and place holding text',
                            style: const TextStyle(
                              color: Colors.black38
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ),
            ),
            GetBuilder<ProductDetailsController>(
              builder: (controller) {
                return PriceOverview(isCart: false,price: controller.productDetails.product?.price??'1000',);
              }
            ),
          ],
        ),
      )
    );
  }
}

class ProductWishlisted extends StatelessWidget {
  const ProductWishlisted({
    super.key,
    required this.productId,
    required this.isWishListed,
  });

  final int productId;
  final bool isWishListed;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddOrRemoveWishListController>(
      builder: (controller) {
        return Container(
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(3)),
                child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: InkWell(
                      onTap: ()async{
                        if (!isWishListed) {
                          await controller.addToWishList(productId);
                        } else {
                          await controller.removeFromWishList(productId);
                        }
                        Get.find<WishListController>().isWishListedCheck(productId);
                      },
                      child: Icon(
                         isWishListed? Icons.favorite : Icons.favorite_outline,
                        size: 13,
                        color: Colors.white,
                      ),
                    )));
          });
  }
}

class SizeSelector extends StatefulWidget {
  const SizeSelector({
    super.key,
    required this.sizes,
  });

  final String sizes;

  @override
  State<SizeSelector> createState() => _SizeSelectorState();
}

class _SizeSelectorState extends State<SizeSelector> {
  @override
  Widget build(BuildContext context) {
    Get.find<AddToCartController>().sizeListSetter(widget.sizes.split(','));
    return SizedBox(
      height: 28,
      child: GetBuilder<AddToCartController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: controller.sizeList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: (){
                    controller.sizeIndexSetter(index);
                  },
                  child: Container(
                    width: 28,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(width: 1,color: Colors.grey),
                      color: index==controller.selectedSizeIndex?AppColors.primaryColor:null,
                    ),
                    child: Center(
                      child: Text(
                        controller.sizeList[index],
                        style: TextStyle(
                          color: index==controller.selectedSizeIndex?Colors.white:Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }
}

class ColorSelector extends StatelessWidget {
  const ColorSelector({
    super.key,
  required this.colors
  });

  final String colors;

  @override
  Widget build(BuildContext context) {
    List<String> colorsNames=colors.split(',');
    Get.find<AddToCartController>().colorListSetter(colorsNames);
    List<Color> colorsList=[];
    for(String colorName in colorsNames){
      colorsList.add(getColor(colorName));
    }
    return SizedBox(
      height: 30,
      child: GetBuilder<AddToCartController>(
        builder: (controller) {
          return ListView.builder(
            itemCount: colorsList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: (){
                    controller.colorIndexSetter(index);
                  },
                  child: CircleAvatar(
                    radius: 13.5,
                    backgroundColor: Colors.black45,
                    child: CircleAvatar(
                      radius: 13,
                      backgroundColor: colorsList[index],
                      child: Visibility(
                        visible: index==controller.selectedColorIndex,
                        child: const Icon(
                          Icons.check,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
      ),
    );
  }

  getColor(String name){
    if(name=='Red'){
      return Colors.redAccent;
    }else if(name=='Green'){
      return Colors.greenAccent;
    }else if(name=='White'){
      return Colors.white;
    }else if(name=='Blue'){
      return Colors.blue;
    }else{
      return Colors.grey;
    }
  }
}

class ReviewsButton extends StatelessWidget {
  const ReviewsButton({
    super.key, required this.productId
  });

  final int productId;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: (){
        Get.to(()=> ReviewsScreen(productId: productId,));
      },
      child: const Text(
        'Reviews',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 14
        ),
      ),
    );
  }
}

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 5,
      child: Text(
        title,
        maxLines: 2,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }
}


class ProductImagesSlideShow extends StatelessWidget {
  const ProductImagesSlideShow({
    super.key,
    // required this.productImages,
  });

  // final List<String> productImages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProductDetailsController>(
      builder: (controller) {
        List<String> productImages=[
          controller.productDetails.img1??"https://photo.teamrabbil.com/images/2023/08/15/macbooks-2048px-2349.md.jpeg",
          controller.productDetails.img2??"https://photo.teamrabbil.com/images/2023/08/15/macbooks-2048px-2349.md.jpeg",
          controller.productDetails.img3??"https://photo.teamrabbil.com/images/2023/08/15/macbooks-2048px-2349.md.jpeg",
          controller.productDetails.img4??"https://photo.teamrabbil.com/images/2023/08/15/macbooks-2048px-2349.md.jpeg",
        ];
        return FlutterCarousel(
          options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: true,
            showIndicator: true,
            slideIndicator: CircularSlideIndicator(
              currentIndicatorColor: AppColors.primaryColor,
              indicatorBorderColor: Colors.grey.withOpacity(0.3),
            ),
            floatingIndicator: true,
            aspectRatio: 1.5,
          ),
          items: productImages.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Visibility(
                      visible: !controller.inProgress,
                      replacement: SizedBox(height: 100,child: const CenterLoader()),
                      child: CachedImage(
                        url: i,
                      ),
                    )
                  ),
                );
              },
            );
          }).toList(),
        );
      }
    );
  }
}


class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight:
        FontWeight.w600,
        color: Colors.black38,
      ),
    );
  }
}

