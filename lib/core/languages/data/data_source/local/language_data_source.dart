abstract class LanguageDataSource {
  Future<String?> getLanguageCode(String key);
  Future<void> setLanguageCode(String key, String code);
}
