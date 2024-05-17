import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

class AppConnectivity {
  static Future<bool> connectivity() async {
    var connectivityResult = await InternetConnection().internetStatus;
    if (connectivityResult == InternetStatus.connected) {
      return true;
    }
    return false;
  }
}
