import 'package:flutter_store/screens/dashboard/dashboard_screen.dart';
import 'package:flutter_store/screens/drawerpage/about_screen.dart';
import 'package:flutter_store/screens/drawerpage/contact_screen.dart';
import 'package:flutter_store/screens/drawerpage/info_screen.dart';
import 'package:flutter_store/screens/forgot-password/forgot_password_screen.dart';
import 'package:flutter_store/screens/login/login_screen.dart';
import 'package:flutter_store/screens/register/register_screen.dart';
import 'package:flutter_store/screens/welcome/welcome_screen.dart';

class AppRouter {
  // Route Names
  static const String welcome = 'welcome';
  static const String login = 'login';
  static const String register = 'register';
  static const String forgotPassword = 'forgotPassword';
  static const String dashboard = 'dashboard';
  static const String info = 'info';
  static const String about = 'about';
  static const String contact = 'contact';

  // Router Map key
  static get routes => {
    welcome: (context) => const WelcomeScreen(),
    login: (context) => const LoginScreen(),
    register: (context) => const RegisterScreen(),
    forgotPassword: (context) => const ForgotPasswordScreen(),
    dashboard: (context) => const DashboardScreen(),
    info: (context) => const InfoScreen(),
    about: (context) => const AboutScreen(),
    contact: (context) => const ContactScreen(),
  };
}
