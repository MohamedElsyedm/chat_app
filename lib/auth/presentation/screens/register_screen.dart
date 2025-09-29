import 'package:chat_app/auth/presentation/screens/login_screen.dart';
import 'package:chat_app/auth/view_model/auth_state.dart';
import 'package:chat_app/auth/view_model/auth_view_model.dart';
import 'package:chat_app/home_screen.dart';
import 'package:chat_app/l10n/app_localizations.dart';
import 'package:chat_app/core/ui_utils.dart';
import 'package:chat_app/auth/presentation/widgets/default_elevated_button.dart';
import 'package:chat_app/auth/presentation/widgets/default_text_form_field.dart';
import 'package:chat_app/core/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = '/register screen';

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size screenSize = MediaQuery.sizeOf(context);
    AppLocalizations appLocalizations = AppLocalizations.of(context)!;

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
                hintText: appLocalizations.name,
                prefixIconImageName: 'name',
                controller: nameController,
                validator: (value) => Validator.validateUsername(value),
              ),
              SizedBox(height: 16),
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
                  if (state is RegisterLoading) {
                    UiUtils.showLoading(context);
                  } else if (state is RegisterSuccess) {
                    Navigator.of(context).pop();
                    UiUtils.showSuccessMessage('Registered Successfully');
                    if (mounted) {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(HomeScreen.routeName);
                    }
                  } else if (state is RegisterError) {
                    Navigator.of(context).pop();
                    UiUtils.showErrorMessage(state.message);
                  }
                },
                child: DefaultElevatedButton(
                  label: appLocalizations.createAccount,
                  onPressed: register,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    appLocalizations.alreadyHaveAccount,
                    style: textTheme.titleMedium,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(
                        context,
                      ).pushReplacementNamed(LoginScreen.routeName);
                    },
                    child: Text(appLocalizations.login),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<AuthViewModel>(context).register(
        name: nameController.text,
        email: emailController.text,
        password: passwordController.text,
      );
    }
  }
}
