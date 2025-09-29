import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/auth/presentation/screens/register_screen.dart';
import 'package:chat_app/auth/view_model/auth_state.dart';
import 'package:chat_app/auth/view_model/auth_view_model.dart';
import 'package:chat_app/core/database_utils.dart';
import 'package:chat_app/home_screen.dart';
import 'package:chat_app/l10n/app_localizations.dart';
import 'package:chat_app/core/languages/view/change_language.dart';
import 'package:chat_app/core/languages/view_model/languages_view_model.dart';
import 'package:chat_app/core/ui_utils.dart';
import 'package:chat_app/auth/presentation/widgets/default_elevated_button.dart';
import 'package:chat_app/auth/presentation/widgets/default_text_form_field.dart';
import 'package:chat_app/core/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login screen';

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final googleAuth = DatabaseUtils();
  late AppLocalizations appLocalizations;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    appLocalizations = AppLocalizations.of(context)!;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/chat_logo.jpg',
                height: screenSize.height * 0.2,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 24),
              DefaultTextFormField(
                hintText: appLocalizations.email,
                prefixIconImageName: 'email',
                controller: emailController,
                validator: (value) => Validator.validateEmail(value),
              ),
              SizedBox(height: 16),
              DefaultTextFormField(
                hintText: appLocalizations.password,
                prefixIconImageName: 'password',
                controller: passwordController,
                validator: (value) => Validator.validatePassword(value),
                isPassword: true,
              ),
              SizedBox(height: 24),
              BlocListener<AuthViewModel, AuthState>(
                listener: (context, state) {
                  if (state is LoginLoading) {
                    UiUtils.showLoading(context);
                  } else if (state is LoginSuccess) {
                    Navigator.of(context).pop();
                    UiUtils.showSuccessMessage('Logged in Successfully');
                    Navigator.of(
                      context,
                    ).pushReplacementNamed(HomeScreen.routeName);
                  } else if (state is LoginError) {
                    Navigator.of(context).pop();
                    UiUtils.showErrorMessage(state.message);
                  }
                },
                child: DefaultElevatedButton(
                  label: appLocalizations.login,
                  onPressed: login,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.dontHaveAccount,
                    style: textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(RegisterScreen.routeName);
                    },
                    child: Text(appLocalizations.createAccount),
                  ),
                ],
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: screenSize.width * 0.35,
                    color: AppTheme.primary,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      appLocalizations.or,
                      style: textTheme.titleMedium!.copyWith(
                        color: AppTheme.primary,
                      ),
                    ),
                  ),
                  Container(
                    height: 1,
                    width: screenSize.width * 0.35,
                    color: AppTheme.primary,
                  ),
                ],
              ),
              SizedBox(height: MediaQuery.sizeOf(context).height * 0.02),
              ChangeLanguageWidget(context.watch<LanguagesViewModel>()),
            ],
          ),
        ),
      ),
    );
  }

  void login() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthViewModel>(
        context,
      ).login(email: emailController.text, password: passwordController.text);
    }
  }
}
