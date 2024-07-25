import 'package:shared_preferences/shared_preferences.dart';

class SP{


// Function to save data to SharedPreferences
  static Future<void> setJWT(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

// Function to read data from SharedPreferences
  static Future<String?> getJWT(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  static deleteJWT ()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<void> setLang(String key, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

// Function to read data from SharedPreferences
  static Future<String?> getLang(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }
  
}