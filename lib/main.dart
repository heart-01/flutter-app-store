import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/providers/counter_provider.dart';
import 'package:flutter_store/providers/timer_provider.dart';
import 'package:flutter_store/themes/styles.dart';
import 'package:flutter_store/utils/utility.dart';
import 'package:provider/provider.dart';

var initialRoute = AppRouter.welcome;
void main() async {
  // Test Logger
  Utility().testLogger();

  WidgetsFlutterBinding
      .ensureInitialized(); // Must be used when the main function is async

  await Utility.initSharedPrefs();
  if (await Utility.getSharedPreference('user') != null) {
    initialRoute = AppRouter.dashboard;
  } else if (await Utility.getSharedPreference('welcomeStatus') == true) {
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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CounterProvider()), // _ = context (not used in this case)
        ChangeNotifierProvider(create: (_) => TimerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        initialRoute: initialRoute,
        routes: AppRouter.routes,
      ),
    );
  }
}
