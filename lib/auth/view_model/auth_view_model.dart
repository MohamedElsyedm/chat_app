import 'package:chat_app/auth/view_model/auth_state.dart';
import 'package:chat_app/core/database_utils.dart';
import 'package:chat_app/auth/data/models/user_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthViewModel extends Cubit<AuthState> {
  AuthViewModel() : super(AuthInitial());

  UserModel? currentUser;

  Future<void> login({required String email, required String password}) async {
    emit(LoginLoading());
    try {
      currentUser = await DatabaseUtils.login(email: email, password: password);
      emit(LoginSuccess());
    } catch (exception) {
      emit(LoginError(exception.toString()));
    }
  }

  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      currentUser = await DatabaseUtils.register(
        name: name,
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } catch (exception) {
      emit(RegisterError(exception.toString()));
    }
  }

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      Future.delayed(Duration(seconds: 2));
      DatabaseUtils.logout();
      currentUser = null;
      emit(LogoutSuccess());
    } catch (error) {
      emit(LogoutError(error.toString()));
    }
  }

  Future<void> getCurrentUser() async {
    try {
      currentUser = await DatabaseUtils.getCurrentUser();
      if (currentUser != null) {
        emit(IsLoggedIn());
      } else {
        emit(NotLogged());
      }
    } catch (_) {
      emit(NotLogged());
    }
  }
}
