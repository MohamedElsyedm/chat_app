abstract class LanguageState {}

class LanguageInit extends LanguageState {}

class LanguageLoading extends LanguageState {}

class LanguageError extends LanguageState {
  String message;
  LanguageError(this.message);
}

class LanguageSuccess extends LanguageState {
  String languageCode;
  LanguageSuccess(this.languageCode);
}
