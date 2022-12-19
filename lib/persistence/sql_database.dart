
import 'package:major_kill_minis/objects/history.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlDatabase {
  static late Database _database;

  static Future openDb() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), "orderHistory.ddb"),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          "CREATE TABLE history(id INTEGER PRIMARY KEY autoincrement, "
              "name TEXT,description TEXT,networkImage TEXT, quantity INTEGER, price TEXT)"
        );
      }
    );
    return _database;
  }//end open DB

  static Future insertItem(History history) async{
    await openDb();
    try {
      return await _database.insert('history', history.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
    }catch (error) {
      throw Exception(error.toString());
    }//end try-catch
  }//end insert item

  static Future<List<History>> getItems() async {
    final List<Map<String, dynamic>> maps = await _database.query('history');

    return List.generate(maps.length, (index){
      return History(
          id: maps[index]['id'], name: maps[index]['name'], description: maps[index]['description'],
          networkImage: maps[index]['networkImage'], quantity: maps[index]['quantity'],
          price: maps[index]['price']
      );
    }).toList();
  }//end get items

}//end class sql database