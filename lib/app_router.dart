import 'package:flutter_store/screens/login/login_screen.dart';
import 'package:flutter_store/screens/welcome/welcome_screen.dart';

class AppRouter {
  // Route Names
  static const String welcome = 'welcome';
  static const String login = 'login';

  // Router Map key
  static get routes => {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
  };
}
