import 'package:chat_app/chat/view/screens/chat_screen.dart';
import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/auth/presentation/screens/login_screen.dart';
import 'package:chat_app/auth/presentation/screens/register_screen.dart';
import 'package:chat_app/auth/view_model/auth_view_model.dart';
import 'package:chat_app/core/bloc_observer.dart';
import 'package:chat_app/core/splash_screen.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/home_screen.dart';
import 'package:chat_app/l10n/app_localizations.dart';
import 'package:chat_app/core/languages/view_model/language_state.dart';
import 'package:chat_app/core/languages/view_model/languages_view_model.dart';
import 'package:chat_app/rooms/view/screens/create_room_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.immersiveSticky,
    overlays: [],
  );
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => LanguagesViewModel()..changeLanguage("en")),
        BlocProvider(create: (_) => AuthViewModel()),
      ],
      child: ChatApp(),
    ),
  );
}

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  late final AuthViewModel authViewModel;

  @override
  void initState() {
    super.initState();
    authViewModel = BlocProvider.of<AuthViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LanguagesViewModel, LanguageState>(
      builder: (context, state) {
        if (state is LanguageLoading) {
          return const Directionality(
            textDirection: TextDirection.ltr,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is LanguageError) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Text(state.message),
          );
        } else if (state is LanguageSuccess) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            routes: {
              HomeScreen.routeName: (ctx) => const HomeScreen(),
              LoginScreen.routeName: (ctx) => const LoginScreen(),
              SplashScreen.routName: (ctx) => const SplashScreen(),
              RegisterScreen.routeName: (ctx) => const RegisterScreen(),
              CreateRoomScreen.routeName: (ctx) => const CreateRoomScreen(),
              ChatScreen.routeName: (ctx) => const ChatScreen(),
            },
            themeMode: ThemeMode.light,
            theme: AppTheme.lightTheme,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(state.languageCode),
          );
        } else {
          return const Directionality(
            textDirection: TextDirection.ltr,
            child: Text('Initial State'),
          );
        }
      },
    );
  }
}
