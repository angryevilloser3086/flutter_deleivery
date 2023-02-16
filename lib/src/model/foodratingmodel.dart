class FoodClip {
  String? foodImage;
  double? rating;
  String? name;
  String? distance;
  String? time;
  String? nOrders;
  String desc;
  String price;
  FoodClip(
      {required this.name,
      required this.foodImage,
      required this.time,
      required this.distance,
      required this.rating,
      required this.nOrders,
      required this.desc,
      required this.price});
}
