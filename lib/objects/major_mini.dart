class MajorMini {
  final String name;
  final String description;
  final double price;
  final String size;
  final List<dynamic> image;
  final String base;
  final String recommendedProxy;
  final List<dynamic> link;

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
  List getImages(String string) {
    List result = [];
    List splitString = string.split(',');
    return result;
  }
  factory MajorMini.fromJson(Map<String,dynamic> json) {
    return MajorMini(
        name: json['name'],
        description: json['description'],
        price: double.parse(json['price']),
        size: json['size'],
        image:json['images'].split(',') ,
        base: json['base'],
        recommendedProxy: json['proxy'],
        link:json['links'].split(',') );
  }
}