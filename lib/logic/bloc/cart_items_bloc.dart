import 'dart:async';

class CartItemsBloc {

  final cartStreamController = StreamController.broadcast();

  Stream get getStream => cartStreamController.stream;

  final Map allItems = {
    'shop items' : [
      {'name': 'App dev kit', 'price': 20, 'id': 1},
      {'name': 'App consultation', 'price': 100, 'id': 2},
      {'name': 'Logo Design', 'price': 10, 'id': 3},
      {'name': 'Code review', 'price': 90, 'id': 4},
    ],
    'cart items' : []
  };

  void addToCart(item) {
    /// update the quantity in stock
    // check if item is in cart
    List list = allItems['cart items'];
    bool boolean = true;
    for(var element in list ) {
      if (element['name'].contains(item['name'])){
        boolean = false;
      }
    }//end for loop

    if (boolean) {
      allItems['cart items'].add(item);
      cartStreamController.sink.add(allItems);
    }
  }

  void clearCart() {
    allItems.clear();
    allItems.addAll({
      'cart items' : []
    });
    cartStreamController.sink.add(allItems);
  }

  void removeFromCart(item) {
    /// update the quantity in stock
    allItems['cart items'].remove(item);
    cartStreamController.sink.add(allItems);
  }// end remove from cart

  void dispose() {
    cartStreamController.close();
  }//end dispose
}

final bloc = CartItemsBloc(); // EOF