class History {
  final int id;
  final String name;
  final String description;
  final String networkImage;
  final int quantity;
  final String price;

  History({required this.id, required this.name, required this.description,
    required this.networkImage, required this.quantity, required this.price
  });

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name' : name,
      'description' : description,
      'networkImage' : networkImage,
      'quantity' : quantity,
      'price' : price
    };
  }
}