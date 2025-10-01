import 'package:chat_app/auth/presentation/screens/login_screen.dart';
import 'package:chat_app/auth/view_model/auth_state.dart';
import 'package:chat_app/auth/view_model/auth_view_model.dart';
import 'package:chat_app/core/widgets/loading_indicator.dart';
import 'package:chat_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const String routName = '/';
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5));
    BlocProvider.of<AuthViewModel>(context).getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return BlocListener<AuthViewModel, AuthState>(
      listener: (context, state) {
        if (state is IsLoggedIn) {
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        } else if (state is NotLogged) {
          Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            Image.asset(
              'assets/images/chat_logo.jpg',
              width: screenSize.width,
              height: screenSize.height * 0.8,
            ),
            LoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
