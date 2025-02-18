import 'package:ecommerce/data/models/category.dart';
import 'package:ecommerce/data/models/product_model.dart';
import 'package:ecommerce/data/models/promotional_slider_data_model.dart';
import 'package:ecommerce/presentation/controllers/bottom_nav_bar_controller.dart';
import 'package:ecommerce/presentation/controllers/categories_list_controller.dart';
import 'package:ecommerce/presentation/controllers/new_products_controller.dart';
import 'package:ecommerce/presentation/controllers/popular_products_controller.dart';
import 'package:ecommerce/presentation/controllers/promotional_slider_controller.dart';
import 'package:ecommerce/presentation/controllers/spacial_products_controller.dart';
import 'package:ecommerce/presentation/utils/app_colors.dart';
import 'package:ecommerce/presentation/utils/asset_paths.dart';
import 'package:ecommerce/presentation/widgets/CachedImage.dart';
import 'package:ecommerce/presentation/widgets/category_view.dart';
import 'package:ecommerce/presentation/widgets/center_circular_progress_indicator.dart';
import 'package:ecommerce/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import '../widgets/logo.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size sizes = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(sizes),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SearchBar(
                searchTEController: _searchTEController,
              ),
              const SizedBox(
                height: 16,
              ),
              GetBuilder<PromotionalSliderController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: SizedBox(height:sizes.height*0.24,child: const CenterLoader()),
                  child: PromotionalCarousel(
                      carousalItems: controller.promotionalSliderList,
                      sizes: sizes),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              const SectionHeader(title: 'All Categories'),
              GetBuilder<CategoriesListController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: SizedBox(height:sizes.height*0.11,child: const CenterLoader()),
                  child: CategoriesHorizontalScroll(
                    categoriesList: controller.categoriesList,
                    sizes: sizes,
                  ),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              const SectionHeader(title: 'Popular'),
              GetBuilder<PopularProductsController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: SizedBox(height:sizes.height*0.19,child: const CenterLoader()),
                  child: productsHorizontalScroll(
                      sizes, controller.popularProductsList),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              const SectionHeader(title: 'Special'),
              GetBuilder<SpecialProductsController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: SizedBox(height:sizes.height*0.19,child: const CenterLoader()),
                  child: productsHorizontalScroll(
                      sizes, controller.specialProductsList),
                );
              }),
              const SizedBox(
                height: 8,
              ),
              const SectionHeader(title: 'New'),
              GetBuilder<NewProductsController>(builder: (controller) {
                return Visibility(
                  visible: !controller.inProgress,
                  replacement: SizedBox(height:sizes.height*0.19,child: const CenterLoader()),
                  child: productsHorizontalScroll(
                      sizes, controller.newProductsList),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget productsHorizontalScroll(Size sizes, List<Product> popularProducts) {
    return SizedBox(
      height: sizes.height * 0.185,
      child: ListView.separated(
        itemCount: popularProducts.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return SizedBox(
            width: sizes.width * 0.32,
            child: ProductCard(
              sizes: sizes,
              product: popularProducts[index],
            ),
          );
        },
        separatorBuilder: (context, _) {
          return const SizedBox(
            width: 5,
          );
        },
      ),
    );
  }

  AppBar buildAppBar(Size sizes) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Logo(
        path: AssetPaths.navBarLogo,
        scale: sizes.height * 0.045,
      ),
      actions: [
        TopBarIconButtons(
          sizes: sizes,
          selection: 'person',
        ),
        const SizedBox(
          width: 10,
        ),
        TopBarIconButtons(
          sizes: sizes,
          selection: 'dialer',
        ),
        SizedBox(
          width: sizes.height * 0.015,
        ),
        TopBarIconButtons(
          sizes: sizes,
          selection: 'bell',
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class CategoriesHorizontalScroll extends StatelessWidget {
  const CategoriesHorizontalScroll({
    super.key,
    required this.categoriesList,
    required this.sizes,
  });

  final List<Category> categoriesList;
  final Size sizes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: sizes.height * 0.113,
      width: double.maxFinite,
      child: ListView.separated(
        itemCount: categoriesList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return CategoryView(
            category: categoriesList[index],
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 28,
          );
        },
      ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
            if (title == 'All Categories') {
              Get.find<BottomNavBarController>().changeSelectedItem(1);
            }
          },
          child: const Text(
            'See All',
          ),
        ),
      ],
    );
  }
}

class PromotionalCarousel extends StatelessWidget {
  const PromotionalCarousel(
      {super.key, required this.carousalItems, required this.sizes});

  final List<PromotionalSliderData> carousalItems;
  final Size sizes;

  @override
  Widget build(BuildContext context) {
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
        aspectRatio: 1.8,
      ),
      items: carousalItems.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: double.maxFinite,
              margin: const EdgeInsets.only(
                bottom: 32,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedImage(
                        url: i.image!,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: sizes.width * 0.5,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            i.title!,
                            style: TextStyle(
                                fontSize: 18,
                                color: AppColors.primaryColor.withOpacity(0.7),
                                fontWeight: FontWeight.w800),
                          ),
                          Text(
                            i.shortDes!,
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black38,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(80, 35),
                                backgroundColor: Colors.white,
                                shadowColor: AppColors.primaryColor,
                                foregroundColor: AppColors.primaryColor),
                            child: const Text(
                              'Buy Now',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({
    super.key,
    required TextEditingController searchTEController,
  }) : _searchTEController = searchTEController;

  final TextEditingController _searchTEController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _searchTEController,
      decoration: InputDecoration(
        fillColor: Colors.grey.withOpacity(0.15),
        filled: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(8)),
        prefixIcon: const Icon(
          Icons.search,
          size: 30,
          color: Colors.black45,
        ),
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.grey.withOpacity(0.5)),
      ),
    );
  }
}

class TopBarIconButtons extends StatelessWidget {
  const TopBarIconButtons({
    super.key,
    required this.sizes,
    required this.selection,
  });

  final Size sizes;
  final String selection;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      splashColor: AppColors.primaryColor.withOpacity(0.2),
      child: CircleAvatar(
        radius: sizes.height * 0.023,
        backgroundColor: Colors.grey.withOpacity(0.15),
        child: Logo(
          scale:
              selection == 'bell' ? sizes.height * 0.045 : sizes.height * 0.023,
          path: selection == 'person'
              ? AssetPaths.navBarPersonLogo
              : selection == 'dialer'
                  ? AssetPaths.navBarDialerLogo
                  : AssetPaths.navBarBellLogo,
        ),
      ),
    );
  }
}
