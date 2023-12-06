import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/themes/styles.dart';
import 'package:flutter_store/utils/utility.dart';

var initialRoute = AppRouter.welcome;
void main() async {
  // Test Logger
  Utility().testLogger();

  WidgetsFlutterBinding .ensureInitialized(); // Must be used when the main function is async

  await Utility.initSharedPrefs();
  if (Utility.getSharedPreference('welcomeStatus') == true) {
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
