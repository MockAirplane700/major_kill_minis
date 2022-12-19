import 'package:major_kill_minis/objects/history.dart';
import 'package:major_kill_minis/persistence/sql_database.dart';

class HistoryLogic {
  static Future getHistory() async {
    return SqlDatabase.getItems();
  }//end get history

  static Future addHistory(History history) async {
    return await SqlDatabase.insertItem(history);
  }
}