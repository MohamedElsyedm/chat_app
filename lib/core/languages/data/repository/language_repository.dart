import 'package:chat_app/core/languages/data/data_source/local/language_data_source.dart';

class LanguageRepository {
  final LanguageDataSource languageDataSource;
  const LanguageRepository(this.languageDataSource);

  Future<String?> getLanguageCode(String key) async {
    return languageDataSource.getLanguageCode(key);
  }

  Future<void> setLanguageCode(String key, String code) async {
    languageDataSource.setLanguageCode(key, code);
  }
}
