class CategoriesModel {
  String? categories_id;
  String? categories_name;
  String? categories_name_ar;
  String? categories_image;

  CategoriesModel({
    this.categories_id,
    this.categories_name,
    this.categories_name_ar,
    this.categories_image,
  });

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categories_id = json['categories_id'];
    categories_name = json['categories_name'];
    categories_name_ar = json['categories_name_ar'];
    categories_image = json['categories_image'];
  }

Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['categories_id'] = this.categories_id;
  data['categories_name'] = this.categories_name;
  data['categories_name_ar'] = this.categories_name_ar;
  data['categories_image'] = this.categories_image;

  return data;
}
}