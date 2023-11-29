import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/themes/styles.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Logger
final logger = Logger(
  printer: PrettyPrinter(
    methodCount: 1,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

void testLogger() {
  logger.t('Verbose log');
  logger.d('Debug log');
  logger.i('Info log');
  logger.w('Warning log');
  logger.e('Error log');
  logger.f('What a terrible failure log');
}

var initialRoute = AppRouter.welcome;
void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Must be used when the main function is async

  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.getBool('welcomeStatus') == true) {
    initialRoute = AppRouter.login;
  }

  runApp(
    const App(),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: initialRoute,
      routes: AppRouter.routes,
    );
  }
}
