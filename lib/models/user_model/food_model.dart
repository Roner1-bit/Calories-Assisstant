class FoodModel {
  String foodName;
  String calories;
  String serving;
  String imageUrl;


  FoodModel(
  {
    required this.foodName,
    required this.calories,
    required this.serving,
    required this.imageUrl
  });

  Map<String, dynamic> toMap() {
    return {
      'foodName': foodName,
      'calories': calories,
      'weight': serving,
      'imageUrl': imageUrl
    };
  }
}