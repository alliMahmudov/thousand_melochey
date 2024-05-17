import 'package:shared_preferences/shared_preferences.dart';

class SP{


// Function to save data to SharedPreferences
  static Future<void> saveToSP(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

// Function to read data from SharedPreferences
  static Future<String?> readFromSP(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

}