class Merch {
  final String name;
  final String description;
  final List<dynamic> size;
  final List<dynamic> images;
  final String link;
  final double price;

  Merch({required this.name, required this.description, required this.size,
    required this.link, required this.images, required this.price});

  factory Merch.fromJson(Map<String,dynamic> json){
    return Merch(
        name: json['name'], description: json['description'],
        size: json['size'].split(','), link: json['link'],
        images: json['images'].split(','), price: double.parse(json['price']));
  }
}
