import 'package:major_kill_minis/persistence/database.dart';

class MerchandiseLogic {
  static Future getMerchandise() async {
    return PersistentDatabase.getMerchandise();
  }//end get merchandise

}