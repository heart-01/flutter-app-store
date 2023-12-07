import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_store/app_router.dart';
import 'package:flutter_store/providers/locale_provider.dart';
import 'package:flutter_store/themes/colors.dart';
import 'package:flutter_store/utils/utility.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String? firstName, lastName, email;

  getUserProfile() async {
    final user = await Utility.getSharedPreference('user');
    final userInfo = jsonDecode(user);

    setState(() {
      firstName = userInfo['userInfo']['firstname'];
      lastName = userInfo['userInfo']['lastname'];
      email = userInfo['userInfo']['email'];
    });
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

  @override
  void initState() {
    super.initState();
    getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ListView(
            shrinkWrap: true,
            children: [
              _buildHeader(),
              _buildListMenu(),
            ],
          )
        ],
      ),
    );
  }

  // widget for show profile from shared preference
  Widget _buildHeader() {
    return Container(
      height: 250,
      decoration: const BoxDecoration(
        color: primary,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            AppLocalizations.of(context)!.hello,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(height: 10),
          const CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage('assets/images/noavartar.png'),
          ),
          const SizedBox(height: 10),
          Text(
            '$firstName $lastName',
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          Text(
            '$email',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  // widget for menu list
  Widget _buildListMenu() {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.person),
          title: Text(AppLocalizations.of(context)!.menu_account),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.password),
          title: Text(AppLocalizations.of(context)!.menu_changepass),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.language),
          title: Text(AppLocalizations.of(context)!.menu_changelang),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {
            // Create alert dialog select language
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(AppLocalizations.of(context)!.menu_changelang),
                  content: SingleChildScrollView(
                    child: Consumer<LocaleProvider>(
                      builder: (context, provider, child) {
                        return ListBody(
                          children: [
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('English'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLanguage(
                                  const Locale('en'),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('ไทย'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLanguage(
                                  const Locale('th'),
                                );
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              child: const Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Text('中國人'),
                              ),
                              onTap: () {
                                Navigator.pop(context);
                                provider.changeLanguage(
                                  const Locale('zh'),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.settings),
          title: Text(AppLocalizations.of(context)!.menu_setting),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: () {},
        ),
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: Text(AppLocalizations.of(context)!.menu_logout),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
          onTap: handleOnClickLogout,
        ),
      ],
    );
  }
}
