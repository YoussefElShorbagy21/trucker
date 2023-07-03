import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/modules/customer/screens/home/cubit/state.dart';
import 'package:login/modules/customer/screens/ordercustomer/cubit/order_cubit.dart';
import 'package:login/shared/resources/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../shared/components/constants.dart';
import '../../../../../shared/network/remote/dio_helper.dart';
import '../../../../../shared/resources/color_manager.dart';
import '../../chats_screen/test_chat_screen.dart';
import '../../favorite/favorite.dart';
import '../../home/cubit/cubit.dart';
import '../../ordercustomer/order_customer.dart';
import '../edit_profile/edit_profile.dart';
import 'setting_page.dart';
import '../update_password/updatePassword.dart';
import 'AccountSetting_page.dart';


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

Widget buildLogout(BuildContext context) => ListTile(
      onTap: () {
        sinOut(context);
      },
      leading: const IconWidget(
        icon: Icons.logout,
        color: Colors.blueAccent,
      ),
      title:  Text(
        'Logout'.tr(context),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );
Widget buildDeleteAccount(BuildContext context) => ListTile(
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
                          sinOut(context);
                        }, child: const Text('Apply')),
                      ],
                    ),
                  ],
                ),

              );
            }
        );
      },
      leading: const IconWidget(
        icon: Icons.delete,
        color: Colors.pinkAccent,
      ),
      title:  Text(
        'Delete Account'.tr(context),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );
Widget buildImageChange(BuildContext context) => ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => EditProfileScreen()));
      },
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
      title:  Text(
        'Profile'.tr(context),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildDarkMode(BuildContext context, bool isDarkMode) => SwitchListTile(
      onChanged: (isDarkMode) {
        isDarkMode = !isDarkMode;
      },
      value: false,
      title: const Row(
        children: [
          IconWidget(
            icon: Icons.dark_mode,
            color: Color(0xFF642ef3),
          ),
          SizedBox(
            width: 8,
          ),
          Text('DarkMode'),
        ],
      ),
    );

Widget buildAccountSetting(BuildContext context) => ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => const AccountSettingPage()));
      },
      leading: const IconWidget(
        icon: Icons.person,
        color: Colors.green,
      ),
      title: const Text(
        'Account Settings',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: const Text(
        'Privacy, Security, Language',
      ),
      subtitleTextStyle: const TextStyle(color: Colors.blueGrey, fontSize: 10),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildSupport(context) => ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => TestChatScreen()));
      },
      leading: const IconWidget(
        icon: Icons.support_agent_outlined,
        color: Colors.blue,
      ),
      title: const Text(
        'Support',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildPaymentMethod() => ListTile(
      onTap: () {},
      leading: const IconWidget(
        icon: Icons.payments_rounded,
        color: Colors.amber,
      ),
      title: const Text(
        'Payment Method',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildNotification() => ListTile(
      onTap: () {},
      leading: const IconWidget(
        icon: Icons.notifications,
        color: Colors.orangeAccent,
      ),
      title: const Text(
        'Notifications',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildMyOrder(context) => ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => const OrderCustomer()));
      },
      leading: const IconWidget(
        icon: Icons.add_task_outlined,
        color: Colors.green,
      ),
      title: const Text(
        'My Orders',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildFavorite(context) => ListTile(
  onTap: () {
    Navigator.push(context, MaterialPageRoute(builder: (_) => FavoriteScreen()));
  },
  leading: const IconWidget(
    icon: Icons.favorite,
    color: Colors.red,
  ),
  title:  const Text(
    'Favorites',
    style: TextStyle(
      fontSize: 16,
    ),
  ),
  trailing:  const Icon(
    Icons.arrow_forward_ios,
    size: 12,
  ),
);

Widget buildUpdatePassword(context) => ListTile(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => UpdatePassword()));
      },
      leading: const IconWidget(
        icon: Icons.password,
        color: Colors.blue,
      ),
      title:  Text(
        'Update Password'.tr(context),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildConfirmAccess() => ListTile(
      onTap: () {},
      leading: const IconWidget(
        icon: Icons.qr_code_2,
        color: Colors.teal,
      ),
      title: const Text(
        'Confirm Access',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: const Text(
        'Confirm process by Pin Or QR Code ',
      ),
      subtitleTextStyle: const TextStyle(color: Colors.blueGrey, fontSize: 10),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildJoinUS(BuildContext context) => ListTile(
      onTap: () {},
      leading: const IconWidget(
        icon: Icons.fire_truck,
        color: Colors.teal,
      ),
      title: const Text(
        'Join Us',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      subtitle: const Text(
        'Become a trucker to get your job',
      ),
      subtitleTextStyle: const TextStyle(color: Colors.blueGrey, fontSize: 10),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

Widget buildReportBug() => ListTile(
      onTap: () {},
      leading: const IconWidget(
        icon: Icons.bug_report,
        color: Colors.teal,
      ),
      title: const Text(
        'Report Bug',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );
Widget buildSendFeedback() => ListTile(
      onTap: () {},
      leading: const IconWidget(
        icon: Icons.thumb_up,
        color: Colors.purpleAccent,
      ),
      title: const Text(
        'Send FeedBack',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 12,
      ),
    );

class SetLanguage extends StatefulWidget {
  const SetLanguage({super.key});

  @override
  State<SetLanguage> createState() => _SetLanguageState();
}

class _SetLanguageState extends State<SetLanguage> {
  List<String> languageList = ['English', 'Arabic'];
  String? selectedlanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const IconWidget(
        icon: Icons.language,
        color: Colors.blueAccent,
      ),
      title:  Text(
        'Languages'.tr(context),
        style: const TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: BlocConsumer<HomeCubit, HomeStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return DropdownButton<String>(
        value: selectedlanguage,
        onChanged: (language) {
          if (language == languageList[0]) {
            context.read<HomeCubit>().cachedLanguageCode('en');
          } else {
            context.read<HomeCubit>().cachedLanguageCode('ar');
          }
        },
        items: languageList
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList(),
      );
  },
),
    );
  }
}

class SetLocation extends StatefulWidget {
  const SetLocation({super.key});

  @override
  State<SetLocation> createState() => _SetLocationState();
}

class _SetLocationState extends State<SetLocation> {
  List<String> languageList = [
    'الإسكندرية',
    'الإسماعيلية',
    'أسوان',
    'أسيوط',
    'الأقصر',
    'البحر الأحمر',
    'البحيرة',
    '	بني سويف',
    'بورسعيد',
    'جنوب سيناء',
    'الجيزة',
    'الدقهلية',
    'دمياط',
    '	سوهاج',
    '	السويس',
    'الشرقية',
    '	شمال سيناء',
    'الغربية',
    '	الفيوم',
    'القاهرة',
    'القليوبية',
    'اختر المحافظة',
  ];
  String? selectedlanguage = 'اختر المحافظة';

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      leading: const IconWidget(
        icon: Icons.location_on,
        color: Colors.deepOrangeAccent,
      ),
      title: const Text(
        'Location',
        style: TextStyle(
          fontSize: 16,
        ),
      ),
      trailing: DropdownButton<String>(
        value: selectedlanguage,
        onChanged: (item) => setState(() => selectedlanguage = item),
        items: languageList
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
