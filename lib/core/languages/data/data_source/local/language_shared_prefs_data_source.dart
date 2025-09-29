import 'package:chat_app/core/languages/data/data_source/local/language_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageSharedPrefsDataSource implements LanguageDataSource {
  @override
  Future<String?> getLanguageCode(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(key);
  }

  @override
  Future<void> setLanguageCode(String key, String code) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(key, code);
  }
}
