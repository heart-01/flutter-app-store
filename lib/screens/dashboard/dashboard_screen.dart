import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/screens/bottomnavpage/home_screen.dart';
import 'package:flutter_store/screens/bottomnavpage/notification_screen.dart';
import 'package:flutter_store/screens/bottomnavpage/profile_screen.dart';
import 'package:flutter_store/screens/bottomnavpage/report_screen.dart';
import 'package:flutter_store/screens/bottomnavpage/setting_screen.dart';
import 'package:flutter_store/themes/colors.dart';
import 'package:flutter_store/utils/utility.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Bottom Navigation
  String titleScreen = 'Flutter Store';
  int indexCurrentRenderScreen = 0;
  final List<Widget> renderScreen = const [
    HomeScreen(),
    ReportScreen(),
    NotificationScreen(),
    SettingScreen(),
    ProfileScreen()
  ];

  void handleOnClickBottomNavigation(int index) {
    setState(
      () {
        indexCurrentRenderScreen = index;
        switch (index) {
          case 0:
            titleScreen = 'Home';
            break;
          case 1:
            titleScreen = 'Report';
            break;
          case 2:
            titleScreen = 'Notification';
            break;
          case 3:
            titleScreen = 'Setting';
            break;
          case 4:
            titleScreen = 'Profile';
            break;
          default:
            titleScreen = 'Flutter Store';
        }
      },
    );
  }

  handleOnClickLogout() {
    // Remove user shared preference
    Utility.removeSharedPreference('user');

    // Clear all route and push to login screen
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRouter.login,
      (route) => false,
    );
  }

  String? firstName, lastName, email;
  getUserProfile() async {
    final userInfo = await Utility.getSharedPreference('user');
    final user = jsonDecode(userInfo);

    setState(() {
      firstName = user['userInfo']['firstname'];
      lastName = user['userInfo']['lastname'];
      email = user['userInfo']['email'];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleScreen),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text('$firstName $lastName'),
                  accountEmail: Text('$email'),
                  currentAccountPicture: const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/avatar.jpeg'),
                  ),
                  otherAccountsPictures: const [
                    CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/noavartar.png'),
                    ),
                  ],
                ),
                ListTile(
                  leading: const Icon(Icons.timer_outlined),
                  title: const Text('Couter (With Stateful)'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.counterStateful);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.timer_outlined),
                  title: const Text('Couter (With Provider)'),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.counterProvider);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(AppLocalizations.of(context)!.menu_info),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.info);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: Text(AppLocalizations.of(context)!.menu_about),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.about);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.email_outlined),
                  title: Text(AppLocalizations.of(context)!.menu_contact),
                  onTap: () {
                    Navigator.pushNamed(context, AppRouter.contact);
                  },
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ListTile(
                    leading: const Icon(Icons.exit_to_app_outlined),
                    title: Text(AppLocalizations.of(context)!.menu_logout),
                    onTap: handleOnClickLogout,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: renderScreen[indexCurrentRenderScreen],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: indexCurrentRenderScreen,
        onTap: (index) {
          handleOnClickBottomNavigation(index);
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryDark,
        unselectedItemColor: secondaryText,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home_outlined),
            label: AppLocalizations.of(context)!.menu_home,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.bar_chart_outlined),
            label: AppLocalizations.of(context)!.menu_report,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.notifications_outlined),
            label: AppLocalizations.of(context)!.menu_notification,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings_outlined),
            label: AppLocalizations.of(context)!.menu_setting,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: AppLocalizations.of(context)!.menu_profile,
          ),
        ],
      ),
    );
  }
}
