class ProductModel {
  final String name;
  final String price;
  final String img;
  final String category;
  final String description;

  ProductModel({
    required this.category,
    required this.name,
    required this.price,
    required this.img,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": this.name,
      "price": this.price,
      "img": this.img,
      "category": this.category,
      "description": this.description
    };
  }
}
