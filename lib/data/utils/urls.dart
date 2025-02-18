class Urls{
  static const String _baseUrl='http://ecom-api.teamrabbil.com/api';

  static const String promotionalSliderList='$_baseUrl/ListProductSlider';
  static const String categoriesList='$_baseUrl/CategoryList';

  static String productListByCategory(int categoryId) => '$_baseUrl/ListProductByCategory/$categoryId';
  static String productListByRemark(String remark) => '$_baseUrl/ListProductByRemark/$remark';


  static String productDetails(int id) => '$_baseUrl/ProductDetailsById/$id';
  static String reviewsList(int id) => '$_baseUrl/ListReviewByProduct/$id';
  static String createReview ='$_baseUrl/CreateProductReview';

  static String addToCart = '$_baseUrl/CreateCartList';


  static String addToWishList(int id) => '$_baseUrl/CreateWishList/$id';
  static String deleteFromWishList(int id) => '$_baseUrl/RemoveWishList/$id';
  static String productWishList = '$_baseUrl/ProductWishList';

  static String cartList = '$_baseUrl/CartList';
  static String deleteFromCartList(int cartId) => '$_baseUrl/DeleteCartList/$cartId';


  static String emailVerify(String email) => '$_baseUrl/UserLogin/$email';
  static String otpVerify(String email,String otp) => '$_baseUrl/VerifyLogin/$email/$otp';
  static String readProfile = '$_baseUrl/ReadProfile';
  static String createProfile = '$_baseUrl/CreateProfile';

}