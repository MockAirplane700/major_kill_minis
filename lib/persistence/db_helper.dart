import 'dart:io' as io;

import 'package:major_kill_minis/objects/cart.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null){
      return _database!;
    }//end if

    _database = await initDatabase();
    return null;
  }//end get database

  initDatabase() async{
    io.Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'cart.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }//end init database

  _onCreate( Database db, int version) async {
    await db.execute(
      'CREATE TABLE cart(id INTEGER PRIMARY KEY, productId VARCHAR UNIQUE,productName TEXT, initialPrice INTEGER, productPrice INTEGER, quantity INTEGER, size TEXT, image TEXT)'
    );
  }//end method

  Future<Cart> insert(Cart cart) async {
    var dbClient = await database;
    await dbClient?.insert('cart', cart.toMap());
    return cart;
  }//end insert

  Future<List<Cart>> getCartList() async {
    var dbClient = await database;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('cart');
    return queryResult.map((e) => Cart.fromMap(e)).toList();
  }//end get cart list

  Future<int> updateQuantity(Cart cart) async {
    var dbClient = await database;
    return await dbClient!.update('cart', cart.toMap(), where:"productId=?", whereArgs: [cart.productId]);
  }//end update quantity

  Future<int> deleteCartItem(int id) async {
    var dbClient = await database;
    return await dbClient!.delete(
      'cart',where: 'id=?', whereArgs: [id]
    );
  }

}//end class