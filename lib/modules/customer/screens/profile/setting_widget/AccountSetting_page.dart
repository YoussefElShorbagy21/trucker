import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/profile/setting_widget/settings_widget.dart';

class AccountSettingPage extends StatelessWidget {
  const AccountSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          const SetLanguage(),
          // const Divider(),
          const SizedBox(height: 8),
          const SetLocation(),
          // const Divider(),
          const SizedBox(height: 35),
          buildUpdatePassword(context),
          const SizedBox(height: 8),
          buildConfirmAccess(context),
        ],
      ),
    );
  }
}
