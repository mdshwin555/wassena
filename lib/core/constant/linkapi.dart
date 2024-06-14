class AppLink {
  static const String server = "https://api.wasenahon.com/";
  // static const String server = "https://wasena.shop/";
  // static const String server = "https://yumyumdelivery.000webhostapp.com/";

  static const String categories_image = "$server/upload/categories/";
  static const String items_image = "$server/upload/items/";
  static const String restaurants_image = "$server/upload/restaurants/";
  static const String offers_image = "$server/upload/offers/";

  // ================================= Auth ========================== //
  static const String signIn = "$server/admin/auth/login.php";

  // ================================= Home ========================== //
  static const String viewcategories = "$server/admin/categories/view.php";
  static const String deleteresturant = "$server/admin/restaurants/delete.php";
  static const String addcategories = "$server/admin/categories/add.php";
  static const String editcategories = "$server/admin/categories/edit.php";
  static const String deletecategories = "$server/admin/categories/delete.php";

  static const String viewitems = "$server/admin/items/view.php";
  static const String additems = "$server/admin/items/add.php";
  static const String edititems = "$server/admin/items/edit.php";
  static const String deleteitems = "$server/admin/items/delete.php";

  static const String viewrestaurants = "$server/admin/restaurants/view.php";
  static const String addrestaurants = "$server/admin/restaurants/add.php";
  static const String editrestaurants = "$server/admin/restaurants/edit.php";

  static const String viewoffers = "$server/admin/offers/view.php";
  static const String addoffers = "$server/admin/offers/add.php";
  static const String deleteoffers = "$server/admin/offers/delete.php";

  static const String pending = "$server/admin/orders/viewpending.php";
  static const String getpreparing = "$server/admin/orders/viewpreparing.php";
  static const String getonway = "$server/admin/orders/viewonway.php";
  static const String getarchive = "$server/admin/orders/archive.php";
  static const String approve = "$server/admin/orders/approve.php";
  static const String prepare = "$server/admin/orders/prepare.php";
  static const String reject = "$server/admin/orders/reject.php";
  static const String details = "$server/admin/orders/details.php";
  static const String additem = "$server/admin/orders/add.php";
  static const String new_delivery_price = "$server/admin/orders/update_delivery_price.php";
  static const String removeitem = "$server/admin/orders/delete.php";
  static const String create_captain = "$server/admin/delivery/delivery_create.php";

  static const String all_captains = "$server/admin/delivery/all_delivery.php";
  static const String online_captains = "$server/admin/delivery/online_delivery.php";
  static const String users = "$server/admin/users/view.php";
  static const String blockusers = "$server/admin/users/block.php";
  static const String singleotification = "$server/singlenotification.php";
  static const String allotifications = "$server/Allnotification.php";
}
