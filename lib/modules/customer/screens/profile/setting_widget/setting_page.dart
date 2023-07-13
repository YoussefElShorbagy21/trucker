import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/profile/setting_widget/settings_widget.dart';
import 'package:login/shared/resources/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
           Text(
            'Settings'.tr(context),
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
          buildImageChange(context),
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: buildDarkMode(context, isDark),
          ),
          const SizedBox(
            height: 8,
          ),
          SetLanguage(),//buildAccountSetting(context),
          const SizedBox(
            height: 8,
          ),
          buildUpdatePassword(context),//buildNotification(context),
          const SizedBox(height: 8,),
          buildJoinUS(context),
          const SizedBox(
            height: 80,
          ),
          // const Divider(),

           Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Account'.tr(context)),
          ),
          const SizedBox(height: 8),
          buildLogout(context),
          const SizedBox(height: 8),
          buildDeleteAccount(context),
        ],
      ),
    );
  }
}
