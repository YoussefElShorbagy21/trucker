import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/modules/customer/screens/chats_screen/test_chat_screen.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../../layout/homeLayout/cubit/cubit.dart';
import '../../../../../models/chat_model/message_model.dart';
import '../../../../../shared/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteContacts extends StatelessWidget {
  const FavouriteContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var cubit = HomeCubit.get(context).allUserData.allUser ;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Favourite Contacts'.tr(context),
                  style: TextStyle(
                    color: ColorManager.blueGrey,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.0,
                  ),
                ),
                // IconButton(
                //   onPressed: () {},
                //   icon: const Icon(
                //     Icons.more_horiz,
                //   ),
                //   iconSize: 30.0,
                //   color: ColorManager.blueGrey,
                // ),
              ],
            ),
          ),
          SizedBox(
            height: heightScreen / 6,
            child: ListView.builder(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              scrollDirection: Axis.horizontal,
              itemCount: cubit.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TestChatScreen(),
                    ),
                  ),
                  child: cubit[index].id != HomeCubit.get(context).oneUserData.userData.id ?
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 35.0,
                          backgroundImage: cubit[index].avatar.isNotEmpty ? NetworkImage(cubit[index].avatar) :
                          const NetworkImage('https://t3.ftcdn.net/jpg/03/29/17/78/360_F_329177878_ij7ooGdwU9EKqBFtyJQvWsDmYSfI1evZ.jpg',),
                          child: cubit[index].avatar.isNotEmpty ? null : Text(
                            cubit[index].name[0].toUpperCase(),
                            style: TextStyle(
                              fontSize: 40,
                              color: ColorManager.black,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: heightScreen / 85, //6.0
                        ),
                        Text(
                          cubit[index].name,
                          style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ) : Container(),
                );
              },
            ),
          ),
        ],
      ),
    );
  },
);
  }
}
