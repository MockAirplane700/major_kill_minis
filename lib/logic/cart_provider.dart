import 'package:flutter/cupertino.dart';
import 'package:major_kill_minis/objects/cart.dart';
import 'package:major_kill_minis/persistence/db_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  DbHelper dbHelper = DbHelper();
  int _counter = 0;
  int _quantity = 0;
  int get counter => _counter;
  int get quantity => _quantity;

  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  List<Cart> cart = [];

  Future<List<Cart>> getData() async {
    cart = await dbHelper.getCartList();
    notifyListeners();
    return cart;
  }//end get data

  void _setPrefsItems() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt('cart_items', _counter);
    sharedPreferences.setInt('item_quantity', _quantity);
    sharedPreferences.setDouble('total_price', _totalPrice);
  }//end _set pref items

  void _getPrefsItems() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _counter = sharedPreferences.getInt('cart_items') ?? 0;
    _quantity = sharedPreferences.getInt('item_quantity') ?? 1;
    _totalPrice = sharedPreferences.getDouble('total_price') ?? 0;
  }// end get prefs items

  void addCounter() {
    _counter++;
    _setPrefsItems();
    notifyListeners();
  }//end counter

  void removeCounter() {
    _counter--;
    _setPrefsItems();
    notifyListeners();
  }// end remove counter

  int getCounter() {
    _getPrefsItems();
    return _counter;
  }//end get counter

  void addQuantity(int id ) {
    final index = cart.indexWhere((element) => element.id == id);
    cart[index].quantity.value +=1;
    _setPrefsItems();
    notifyListeners();
  }//end add quantity

  void deleteQuantity(int id) {
    final index = cart.indexWhere((element) => element.id == id );
    final currentQuantity = cart[index].quantity.value;
    if (currentQuantity <= 1){
      currentQuantity == 1;
    }else{
      cart[index].quantity.value = currentQuantity -1;
    }//end if-else

    _setPrefsItems();
    notifyListeners();
  }//end delete quantity

  void removeItem(int id) {
    final index = cart.indexWhere((element) => element.id == id);
    cart.removeAt(index);
    _setPrefsItems();
    notifyListeners();
  }//end remove item

  int getQuantity(int quantity){
    _getPrefsItems();
    return _quantity;
  }//end get quantity

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefsItems();
    notifyListeners();
  }//end product price

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefsItems();
    notifyListeners();
  }//end remove total price

  double getTotalPrice() {
    _getPrefsItems();
    return _totalPrice;
  }//end get total price
}