class MajorMiniLogic {
  static List orderHistory = [];
  static List searchCollection = [];
  static List searchMerch = [];

  static List fetchOrderHistory() {
    // obtain order history from local sql
    return orderHistory;
  }

  static void setOrderHistory(List list) {
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
}