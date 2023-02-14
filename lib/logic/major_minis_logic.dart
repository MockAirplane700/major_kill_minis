import 'dart:math';

import 'package:major_kill_minis/logic/history_logic.dart';
import 'package:major_kill_minis/objects/history.dart';
import 'package:major_kill_minis/persistence/database.dart';

class MajorMiniLogic {
  static List orderHistory = [];
  static List searchCollection = [];
  static List searchMerch = [];

  static List fetchOrderHistory() {
    // obtain order history from local sql
    return orderHistory;
  }

  static void setOrderHistory(List list) {
    // list of cart items
    for (var element in list) {
      HistoryLogic.addHistory(
        History(
            id: Random().nextInt(100000), name:  element['name'], description:  element['description'],
            networkImage:  element['image'], quantity:  element['quantity'],
            price: element['price'].toString()
        )
      );
    }
    orderHistory.addAll(list);
  }

  static List getSearchMinis() {
    return searchCollection;
  }

  static List getSearchMerch() {
    return searchMerch;
  }

  static void setSearchMerch(List list) {
    searchMerch.clear();
    searchMerch.addAll(list);
  }

  static void setSearchCollection(List list) {
    searchCollection.clear();
    searchCollection.addAll(list);
  }

  static Future getMinis() async {
    return PersistentDatabase.getMinis();
  }
}