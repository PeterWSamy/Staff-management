import 'package:shared_preferences/shared_preferences.dart';

class DefaultSharedPreferences {
  
  // Obtain shared preferences.
  Future<SharedPreferences> _prefs(){
    return SharedPreferences.getInstance();
  }
  
  void saveToken(String token) async {
    SharedPreferences prefs = await _prefs();
    await prefs.setString(SharedPreferencesNames.TOKEN_NAME, token);
  }

  void deleteToken() async {
    SharedPreferences prefs = await _prefs();
    await prefs.remove(SharedPreferencesNames.TOKEN_NAME);
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await _prefs();
    return prefs.getString(SharedPreferencesNames.TOKEN_NAME) ?? "";
  }

  

}

class SharedPreferencesNames{
  static const TOKEN_NAME = "token";
}