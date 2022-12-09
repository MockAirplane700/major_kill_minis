class MajorMini {
  final String name;
  final String description;
  final double price;
  final String size;
  final String image;

  MajorMini({
    required this.name, required this.description, required this.price,
    required this.size, required this.image
});

  Map toJson() {
    return {
      'name' : name,
      'description' : description,
      'price' : price,
      'size' : size,
      'image': image
    };
  }
}