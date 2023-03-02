import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';

class AccountPage extends StatelessWidget {
  static const keyLanguage = 'key-language';
  static const keyLocation = 'key-location';
  static const keyPassword = 'key-password';

  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
    title: 'Account Setting',
    subtitle: 'Privacy, Security, Language',
    subtitleTextStyle: const TextStyle(color: Colors.blueGrey, fontSize: 10),
    leading: const IconWidget(
      icon: Icons.person,
      color: Colors.green,
    ),
    child: SettingsScreen(
      title: 'Account Settings',
      children: <Widget>[
        buildLanguage(),
        SizedBox(
          height: 15,
        ),
        buildLocation(),
        SizedBox(
          height: 15,
        ),
        buildPassword(context),
        SizedBox(
          height: 15,
        ),
        buildPrivacy(context),
        SizedBox(
          height: 15,
        ),
        buildSecurity(context),
        SizedBox(
          height: 15,
        ),
        buildAccountInfo(context),
      ],
    ),
  );
}
//===============================================


class IconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;

  const IconWidget({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: Icon(
          icon,
          color: Colors.white,
        ),
      );
}

Widget buildDarkMode() => SwitchSettingsTile(
      settingKey: HeaderPage.keyDarkMode, //remember before status
      leading: const IconWidget(
        icon: Icons.dark_mode,
        color: Color(0xFF642ef3),
      ),
      title: 'Dark Mode',
      onChange: (isDarkMode) {},
    );

Widget buildLogout() => SimpleSettingsTile(
      leading: const IconWidget(
        icon: Icons.logout,
        color: Colors.blueAccent,
      ),
      title: 'Logout',
      onTap: () {},
    );

Widget buildDeleteAccount() => SimpleSettingsTile(
      leading: const IconWidget(
        icon: Icons.delete,
        color: Colors.pinkAccent,
      ),
      title: 'Delete Account',
      onTap: () {},
    );

Widget buildAccount() => SimpleSettingsTile(
      leading: const IconWidget(
        icon: Icons.person,
        color: Colors.green,
      ),
      title: 'Account Setting',
      subtitle: 'Privacy, Security, Language',
      child: Container(),
      onTap: () {},
    );

Widget buildLanguage() => DropDownSettingsTile(
      settingKey: AccountPage.keyLanguage,
      title: 'Languages',
      selected: 1,
      values: const <int, String>{
        1: 'English',
        2: 'Arabic',
      },
      onChange: (language) {},
    );

Widget buildLocation() => TextInputSettingsTile(
      settingKey: AccountPage.keyLocation,
      title: 'Location',
      initialValue: 'Cairo, Egypt',
      onChange: (location) {},
    );

Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
      title: 'Report A Bug',
      leading: const IconWidget(
        icon: Icons.bug_report,
        color: Colors.teal,
      ),
      onTap: () {},
    );

Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
      title: 'Send Feedback',
      leading: const IconWidget(
        icon: Icons.thumb_up,
        color: Colors.purpleAccent,
      ),
      onTap: () {},
    );

Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
      title: 'Privacy',
      leading: const IconWidget(
        icon: Icons.lock,
        color: Colors.blue,
      ),
      onTap: () {},
    );

Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
      title: 'Security',
      leading: const IconWidget(
        icon: Icons.security,
        color: Colors.red,
      ),
      onTap: () {},
    );

Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
      title: 'Account Info',
      leading: const IconWidget(
        icon: Icons.text_snippet,
        color: Colors.purple,
      ),
      onTap: () {},
    );

Widget buildImageChange(BuildContext context) => SimpleSettingsTile(
      title: 'Profile',
      leading: const CircleAvatar(
        radius: 24,
        backgroundImage: AssetImage('assets/images/chat_photo/greg.jpg'),
        // child: Image.asset(
        //   'assets/images/chat_photo/greg.jpg',
        //   width: localWidth * 0.45,
        //   fit: BoxFit.fitWidth,
        // ),
      ),
      child: Container(),
    );

Widget buildPassword(BuildContext context) => TextInputSettingsTile(
      settingKey: AccountPage.keyPassword,
      title: 'Password',
      obscureText: true,
      validator: (password) => password != null && password.length >= 6
          ? null
          : 'Enter 6 characters',
    );

//===================================================

class HeaderPage extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';

  const HeaderPage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildImageChange(context),
          buildDarkMode(),
        ],
      );
}

//================================================

class NotificationsPage extends StatelessWidget {
  static const keyNews = 'key-news';
  static const keyActivity = 'key-activity';
  static const keyNewsletter = 'key-newsletter';
  static const keyAppUpdates = 'key-appUpdates';

  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: 'Notifications',
        subtitle: 'Newsletter, AppUpdates',
    subtitleTextStyle: const TextStyle(color: Colors.blueGrey, fontSize: 10),
        leading: const IconWidget(
          icon: Icons.notifications,
          color: Colors.redAccent,
        ),
    child: SettingsScreen(
      title: 'Notifications',
      children: <Widget>[
        buildNews(),
        const SizedBox(
          height: 15,
        ),
        buildActivity(),
        const SizedBox(
          height: 15,
        ),
        buildNewsletter(),
        const SizedBox(
          height: 15,
        ),
        buildAppUpdates(),
      ],
    ),
      );
}

//==============================================

Widget buildNews() => SwitchSettingsTile(
  settingKey: NotificationsPage.keyNews, //remember before status
  leading: const IconWidget(
    icon: Icons.newspaper,
    color: Colors.blueAccent,
  ),
  title: 'News For You',
  // onChange: (keyNews) {},
);

Widget buildActivity() => SwitchSettingsTile(
  settingKey: NotificationsPage.keyActivity, //remember before status
  leading: const IconWidget(
    icon: Icons.person,
    color: Colors.orange,
  ),
  title: 'Account Activity',
  // onChange: (keyNews) {},
);

Widget buildNewsletter() => SwitchSettingsTile(
  settingKey: NotificationsPage.keyNewsletter, //remember before status
  leading: const IconWidget(
    icon: Icons.text_snippet,
    color: Colors.pinkAccent,
  ),
  title: 'News letter',
  // onChange: (keyNews) {},
);

Widget buildAppUpdates() => SwitchSettingsTile(
  settingKey: NotificationsPage.keyAppUpdates, //remember before status
  leading: const IconWidget(
    icon: Icons.update,
    color: Colors.greenAccent,
  ),
  title: 'App Updates',
  // onChange: (keyNews) {},
);