class AppLink {
   //static const String server = "http://10.0.2.2:80/yumyumapp/yumyum/";
 // static const String server = "http://172.20.10.2:80/yumyumapp/yumyum/";
 static const String server = "https://yumyumdelivery.000webhostapp.com/";


  static const String categories_image = "$server/upload/categories/";
  static const String items_image = "$server/upload/items/";
  static const String offers_image = "$server/upload/offers/";
  static const String restaurants_image = "$server/upload/restaurants/";


  // ================================= Auth ========================== //
  static const String signUp = "$server/auth/signup.php";
  static const String signIn = "$server/auth/login.php";
  static const String update_profile = "$server/auth/editprofile.php";

  // ================================= Home ========================== //
  static const String home = "$server/home.php";
  static const String contactus = "$server/contactus.php";
  static const String offers = "$server/offers.php";
  static const String check_update = "$server/version.php";
  static const String items = "$server/items/items.php";
  static const String itemsnoauth = "$server/items/itemsnoauth.php";
  static const String itemsdetils = "$server/items/details.php";
  static const String search = "$server/items/search.php";
  static const String searchAll = "$server/search.php";
  static const String addfav = "$server/favorite/add.php";
  static const String removefav = "$server/favorite/remove.php";
  static const String viewfav = "$server/favorite/view.php";
  static const String addtocart = "$server/cart/add.php";
  static const String removefromcart = "$server/cart/delete.php";
  static const String viewcart = "$server/cart/view.php";
  static const String addaddress = "$server/address/add.php";
  static const String removeaddress = "$server/address/delete.php";
  static const String viewaddress = "$server/address/view.php";
  static const String checkcoupon = "$server/coupon/checkcoupon.php";
  static const String checkout = "$server/orders/checkout.php";

  static const String pinding = "$server/orders/pending.php";
  static const String onway = "$server/orders/onway.php";
  static const String archive = "$server/orders/archive.php";

  static const String details = "$server/orders/details.php";
  static const String rating = "$server/rating.php";
  static const String itemsrating = "$server/rating/add.php";

  static const String viewrestaurants = "$server/restaurants/view.php";
  static const String viewrestaurantsByID = "$server/restaurants/viewbyId.php";
  static const String itemsrestaurants = "$server/restaurants/itemsrestaurants.php";
  static const String itemsrestaurantsnoauth = "$server/restaurants/itemsrestaurantsnoauth.php";
  static const String categories = "$server/categories/view.php";

  static const String notification = "$server/notification.php";
  static const String removeorder = "$server/orders/delete.php";
}
