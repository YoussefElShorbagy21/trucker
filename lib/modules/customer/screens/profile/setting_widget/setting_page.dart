import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/profile/setting_widget/settings_widget.dart';

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
      appBar: AppBar(),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        children: [
          const Text(
            'Settings',
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
          buildAccountSetting(context),
          const SizedBox(
            height: 8,
          ),
          buildNotification(),
          const SizedBox(height: 8,),
          buildJoinUS(context),
          const SizedBox(
            height: 80,
          ),
          // const Divider(),

          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text('Account'),
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
