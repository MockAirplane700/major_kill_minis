class MajorMini {
  final String name;
  final String description;
  final double price;
  final String size;
  final String image;
  final String base;
  final String recommendedProxy;
  final String link;

  MajorMini({
    required this.name, required this.description, required this.price,
    required this.size, required this.image, required this.base, required this.recommendedProxy, required this.link
});

  Map toJson() {
    return {
      'name' : name,
      'description' : description,
      'price' : price,
      'size' : size,
      'image': image,
      'base': base,
      'recommendedProxy' : recommendedProxy,
      'link' : link
    };
  }
}