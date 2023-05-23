import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_settings_screens/flutter_settings_screens.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/modules/customer/screens/favorite/favorite.dart';
import 'package:login/shared/network/remote/dio_helper.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:login/shared/resources/color_manager.dart';
import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../layout/homeLayout/cubit/state.dart';
import '../../../../../shared/components/constants.dart';
import '../edit_profile/edit_profile.dart';
import '../update_password/updatePassword.dart';

class AccountPage extends StatelessWidget {
  static const keyLanguage = 'key-language';
  static const keyLocation = 'key-location';
  static const keyPassword = 'key-password';

  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) => SimpleSettingsTile(
        title: 'Account Setting'.tr(context),
        subtitle: 'Privacy, Security, Language'.tr(context),
        subtitleTextStyle:
            const TextStyle(color: Colors.blueGrey, fontSize: 10),
        leading: const IconWidget(
          icon: Icons.person,
          color: Colors.green,
        ),
        child: SettingsScreen(
          title: 'Account Settings'.tr(context),
          children: <Widget>[
            buildLanguage(),
            const SizedBox(
              height: 15,
            ),
            buildLocation(context),
            const SizedBox(
              height: 15,
            ),
            buildPassword(context),
            const SizedBox(
              height: 15,
            ),
            buildPrivacy(context),
            const SizedBox(
              height: 15,
            ),
            buildSecurity(context),
            const SizedBox(
              height: 15,
            ),
            buildAccountInfo(context),
          ],
        ),
      );
}

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

Widget buildDarkMode(context) {
  Settings.init(cacheProvider: SharePreferenceCache());
  return SwitchSettingsTile(
    settingKey: HeaderPage.keyDarkMode, //remember before status
    leading: const IconWidget(
      icon: Icons.dark_mode,
      color: Color(0xFF642ef3),
    ),
    title: 'Dark Mode'.tr(context),
    onChange: (isDarkMode) {},
  );
}

Widget buildLogout(BuildContext context) => SimpleSettingsTile(
      leading: const IconWidget(
        icon: Icons.logout,
        color: Colors.blueAccent,
      ),
      title: 'Logout'.tr(context),
      onTap: () {
        sinOut(context);
      },
    );

Widget buildDeleteAccount(BuildContext context) => SimpleSettingsTile(
      leading: const IconWidget(
        icon: Icons.delete,
        color: Colors.pinkAccent,
      ),
      title: 'Delete Account'.tr(context),
      onTap: () {
        showDialog(context: context,
            builder: (BuildContext context) {
              return  AlertDialog(
                content:
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    const Text.rich(
                      TextSpan( text: 'Are you sure?? \n You want delete account !!'),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        ElevatedButton(onPressed: (){
                          Navigator.pop(context);
                        }, child: const Text('Cancel')),
                        const Spacer(),
                        ElevatedButton(onPressed: (){
                          DioHelper.deleteData(url: 'users/deleteMe');
                        }, child: const Text('Apply')),
                      ],
                    ),
                  ],
                ),

              );
            }
        );
        sinOut(context);
      },
    );

Widget buildAccount(context) => SimpleSettingsTile(
      leading: const IconWidget(
        icon: Icons.person,
        color: Colors.green,
      ),
      title: 'Account Setting'.tr(context),
      subtitle: 'Privacy, Security, Language'.tr(context),
      child: Container(),
      onTap: () {},
    );

Widget buildLanguage() => BlocConsumer<HomeCubit, HomeStates>(
    listener: (context, state) {},
    builder: (context, state) {
      return DropDownSettingsTile(
        settingKey: AccountPage.keyLanguage,
        title: 'Languages'.tr(context),
        selected: 1,
        values:  <int, String>{
          1: 'English'.tr(context),
          2: 'Arabic'.tr(context),
        },
        onChange: (language) {
          if (language == 1) {
            context.read<HomeCubit>().cachedLanguageCode('en');
          } else {
            context.read<HomeCubit>().cachedLanguageCode('ar');
          }
        },
      );
    },
  );

Widget buildLocation(context) => TextInputSettingsTile(
      settingKey: AccountPage.keyLocation,
      title: 'Location'.tr(context),
      initialValue: 'Cairo, Egypt'.tr(context),
      onChange: (location) {},
    );

Widget buildReportBug(BuildContext context) => SimpleSettingsTile(
      title: 'Report A Bug'.tr(context),
      leading: const IconWidget(
        icon: Icons.bug_report,
        color: Colors.teal,
      ),
      onTap: () {},
    );

Widget buildSendFeedback(BuildContext context) => SimpleSettingsTile(
      title: 'Send Feedback'.tr(context),
      leading: const IconWidget(
        icon: Icons.thumb_up,
        color: Colors.purpleAccent,
      ),
      onTap: () {},
    );

Widget buildPrivacy(BuildContext context) => SimpleSettingsTile(
      title: 'Privacy'.tr(context),
      leading: const IconWidget(
        icon: Icons.lock,
        color: Colors.blue,
      ),
      onTap: () {},
    );

Widget buildSecurity(BuildContext context) => SimpleSettingsTile(
      title: 'Security'.tr(context),
      leading: const IconWidget(
        icon: Icons.security,
        color: Colors.red,
      ),
      onTap: () {},
    );

Widget buildAccountInfo(BuildContext context) => SimpleSettingsTile(
      title: 'Account Info'.tr(context),
      leading: const IconWidget(
        icon: Icons.text_snippet,
        color: Colors.purple,
      ),
      onTap: () {},
    );

Widget buildImageChange(BuildContext context) => SimpleSettingsTile(
      title: 'Profile'.tr(context),
      leading: CircleAvatar(
        radius: 24,
        backgroundImage: HomeCubit.get(context).oneUserData.userData.avatar.isNotEmpty ? NetworkImage(HomeCubit.get(context).oneUserData.userData.avatar) :
        const NetworkImage('https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',),
        child: HomeCubit.get(context).oneUserData.userData.avatar.isNotEmpty ? null : Text(
          HomeCubit.get(context).oneUserData.userData.name[0].toUpperCase(),
          style: TextStyle(
            fontSize: 22,
            color: ColorManager.black,
          ),
        ),
      ),
      child: EditProfileScreen(),
    );

Widget buildPassword(BuildContext context) => SimpleSettingsTile(
      title: 'Update Password'.tr(context),
      leading: const IconWidget(
        icon: Icons.password_rounded,
        color: Colors.blue,
      ),
      child: UpdatePassword(),
    );

//===================================================

class HeaderPage extends StatelessWidget {
  static const keyDarkMode = 'key-dark-mode';

  const HeaderPage({super.key});

  @override
  Widget build(BuildContext context) => Column(
        children: [
          buildImageChange(context),
          buildDarkMode(context),
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
        title: 'Notifications'.tr(context),
        subtitle: 'Newsletter, AppUpdates'.tr(context),
        subtitleTextStyle:
            const TextStyle(color: Colors.blueGrey, fontSize: 10),
        leading: const IconWidget(
          icon: Icons.notifications,
          color: Colors.redAccent,
        ),
        child: SettingsScreen(
          title: 'Notifications'.tr(context),
          children: <Widget>[
            buildNews(context),
            const SizedBox(
              height: 15,
            ),
            buildActivity(context),
            const SizedBox(
              height: 15,
            ),
            buildNewsletter(context),
            const SizedBox(
              height: 15,
            ),
            buildAppUpdates(context),
          ],
        ),
      );
}

//==============================================

Widget buildNews(context) => SwitchSettingsTile(
      settingKey: NotificationsPage.keyNews, //remember before status
      leading: const IconWidget(
        icon: Icons.newspaper,
        color: Colors.blueAccent,
      ),
      title: 'News For You'.tr(context),
      // onChange: (keyNews) {},
    );

Widget buildActivity(context) => SwitchSettingsTile(
      settingKey: NotificationsPage.keyActivity, //remember before status
      leading: const IconWidget(
        icon: Icons.person,
        color: Colors.orange,
      ),
      title: 'Account Activity'.tr(context),
      enabled: HomeCubit().oneUserData.userData.verified == true ? true : false  ,
      onChange: (keyNews) {

      },
    );

Widget buildNewsletter(context) => SwitchSettingsTile(
      settingKey: NotificationsPage.keyNewsletter, //remember before status
      leading: const IconWidget(
        icon: Icons.text_snippet,
        color: Colors.pinkAccent,
      ),
      title: 'News letter'.tr(context),
      // onChange: (keyNews) {},
    );

Widget buildAppUpdates(context) => SwitchSettingsTile(
      settingKey: NotificationsPage.keyAppUpdates, //remember before status
      leading: const IconWidget(
        icon: Icons.update,
        color: Colors.greenAccent,
      ),
      title: 'App Updates'.tr(context),
      // onChange: (keyNews) {},
    );

Widget buildPayment(context) => SimpleSettingsTile(
      leading: const IconWidget(
        icon: Icons.payment,
        color: Colors.amberAccent,
      ),
      title: 'Payment Method'.tr(context),
      child: const Scaffold(
        body: Center(
            child: Text(
              'Chose you Method',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),),
      ),
      onTap: () {},
    );

Widget buildMyOrder(context) => SimpleSettingsTile(
      leading: const IconWidget(
        icon: Icons.add_task,
        color: Colors.green,
      ),
      title: 'My Orders'.tr(context),
      child: const Scaffold(
        body: Center(
            child: Text(
          'There are no Order for now',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        )),
      ),
      onTap: () {},
    );

Widget buildFavorite(context) => SimpleSettingsTile(
  leading: const IconWidget(
    icon: Icons.favorite,
    color: Colors.red,
  ),
  title: 'My favorite',
  subtitle: 'Here All Your favorite',
  subtitleTextStyle:
  const TextStyle(color: Colors.blueGrey, fontSize: 10),
  child:  FavoriteScreen(),
);
