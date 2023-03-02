import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

import 'setting_widget.dart';

class SettingsChange extends StatefulWidget {
  const SettingsChange({Key? key}) : super(key: key);

  @override
  State<SettingsChange> createState() => _SettingsChangeState();
}

class _SettingsChangeState extends State<SettingsChange> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 80,horizontal: 20),
          children: [
            const Text(
              "Settings",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
            SettingsGroup(
              title: 'Account',
              children: <Widget>[
                const SizedBox(height: 15,),
                const HeaderPage(),
                const SizedBox(
                  height: 8,
                ),
                const AccountPage(),
                const SizedBox(
                  height: 10,
                ),
                const NotificationsPage(),
                const SizedBox(height: 10,),
                buildLogout(),
                const SizedBox(
                  height: 10,
                ),
                buildDeleteAccount(),
              ],
            ),
            const SizedBox(
              height: 70,
            ),
            // const Divider(
            //   height: 15,
            //   thickness: 2,
            // ),
            SettingsGroup(
              title: 'FEEDBACK',
              children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                buildReportBug(context),
                const SizedBox(
                  height: 10,
                ),
                buildSendFeedback(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
