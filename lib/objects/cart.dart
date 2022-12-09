import 'package:flutter/cupertino.dart';

class Cart {
  late final int? id;
  final String? productId;
  final String? productName;
  final double? initialPrice;
  final double? productPrice;
  final ValueNotifier<int> quantity;
  final String? size;
  final String? image;
  
  Cart({
    required this.id, required this.productId, required this.productName,
    required this.initialPrice, required this.productPrice, required this.quantity,
    required this.size, required this.image
});
  
  Cart.fromMap(Map<dynamic, dynamic> data) :
      id = data['id'],
  productId = data['productId'],
  productName = data['productName'],
  initialPrice = double.parse(data['initialPrice'].toString()),
  productPrice = double.parse(data['productPrice'].toString()),
  quantity = ValueNotifier(data['quantity']),
  size = data['size'],
  image = data['image'];
  
  Map<String, dynamic> toMap() {
    return {
      'id' : id,
      'productId' : productId,
      'productName' : productName,
      'initialPrice' : initialPrice,
      'productPrice' : productPrice,
      'quantity' : quantity.value,
      'size' : size,
      'image' : image
    };
  }
      
  
}//end cart