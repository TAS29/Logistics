import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefDataSource {
  static const String isLoggedInKey = 'isLoggedIn';

 // Method to save the logged-in status in shared preferences
  Future<void> setLoggedIn(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  // Method to check if the user is already logged in
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(isLoggedInKey) ?? false;
  }
}