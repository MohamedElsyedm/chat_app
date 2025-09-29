import 'package:chat_app/core/languages/data/repository/language_repository.dart';
import 'package:chat_app/core/languages/view_model/language_state.dart';
import 'package:chat_app/core/languages/view_model/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguagesViewModel extends Cubit<LanguageState> {
  late LanguageRepository languageRepository;
  LanguagesViewModel() : super(LanguageInit()) {
    languageRepository = LanguageRepository(ServiceLocator.languageRepository);
  }

  String languageCode = 'en';

  void changeLanguage(String language) async {
    emit(LanguageLoading());
    try {
      await languageRepository.setLanguageCode("LanguageCode", language);

      languageCode =
          await languageRepository.getLanguageCode("LanguageCode") as String;

      emit(LanguageSuccess(languageCode));
    } catch (error) {
      emit(LanguageError(error.toString()));
    }
  }
}
