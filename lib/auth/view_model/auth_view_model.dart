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
}

/*
 DatabaseUtils.register(
            name: nameController.text,
            email: emailController.text,
            password: passwordController.text,
          )
          .then((user) {
            // no need to listen for this screen and this be on (click or .then)
            Provider.of<UserProvider>(
              context,
              listen: false,
            ).updateCurrentUser(user);
            UiUtils.showSuccessMessage('Registered Successfully');
            if (mounted) {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            }
          })
          .catchError((error) {
            print(error);
            print('=================== error ===================');
            String? errorMessage;
            if (error is FirebaseAuthException) {
              //is => comparing type
              errorMessage = error.message;
            }
            UiUtils.showErrorMessage(errorMessage);
          });
 */
