import 'dart:convert';

import 'package:major_kill_minis/constants/variables.dart';
import 'package:major_kill_minis/objects/major_mini.dart';
import 'package:http/http.dart' as http;
import 'package:major_kill_minis/objects/merch.dart';
class PersistentDatabase {
  static List getProducts() {
    return [];
  }

  static Future getMerchandise() async {
    try {
      final response = await http.get(Uri.parse(merchandiseUrl));
      if (response.statusCode == 200){
        return jsonDecode(response.body);
      }
    } catch (exception) {
      throw Exception(exception.toString());
    }
  }

  static Future getMinis() async {
    try {
      final response = await http.get(Uri.parse(minisUrl));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    }catch(exception) {
      throw Exception(exception.toString());
    }
  }
}

/// [{ _id: {}, name: '', }, { } ] ==> {{ _id: {}, name: '', }, { } }