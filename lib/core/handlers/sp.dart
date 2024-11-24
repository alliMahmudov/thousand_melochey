import 'package:shared_preferences/shared_preferences.dart';

class SP{


// Function to save data to SharedPreferences
  static Future<void> saveJWT(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("JWT", value);
  }

// Function to read data from SharedPreferences
  static Future<String> readJWT() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("JWT") ?? "";
  }

}