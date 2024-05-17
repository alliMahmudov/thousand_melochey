import 'dart:convert';
import 'dart:developer';

class AppApiErrorHelper {
  AppApiErrorHelper._();

  static String message(dynamic data) {
    final errorMessage = json.encode(data ?? {});
    Map<String, dynamic> jsonData = json.decode(errorMessage ?? "{}");
    String message = jsonData['message'] ?? "";
    log(message);
    final data1 = json.encode(jsonData);

    Map<String, dynamic> jsonData1 = json.decode(data1);
    String errors = jsonData1["name"] ?? "";
    String error = jsonData['error'] ?? "";
    if (errors.isNotEmpty && errors != "") {
      return errors.toString();
    } else if (message.isNotEmpty && message != "") {
      return message.toString();
    } else if (error.isNotEmpty && error != "") {
      return error.toString();
    } else {
      return "Kechirasiz no'malum xatolik yuz berdi";
    }
  }
}
