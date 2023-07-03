import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/modules/customer/screens/chats_screen/test_chat_screen.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../../models/chat_model/message_model.dart';
import '../../../../../shared/resources/color_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecentChats extends StatelessWidget {
  const RecentChats({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;
    return BlocConsumer<HomeCubit, HomeStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    var cubit = HomeCubit.get(context).allUserData.allUser ;
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            itemCount: cubit.length,
            itemBuilder: (BuildContext context, int index) {
              final Message chat = chats[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (_) => ChatScreen(user: chat.sender),
                    builder: (_) => TestChatScreen(),
                  ),
                ),
                child:cubit[index].id != HomeCubit.get(context).oneUserData.userData.id ?
                Container(
                  margin: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    right: 20.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4.0,
                  ),
                  decoration: const BoxDecoration(
                    // color: chat.unread
                    //     ? ColorManager.gery.withOpacity(0.3)
                    //     : ColorManager.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 32.0,
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
                            width: widthScreen / 40, //10.0
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cubit[index].name,
                                style: TextStyle(
                                  color: ColorManager.gery,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: heightScreen / 90, //5.0
                              ),
                              SizedBox(
                                width: widthScreen / 2,
                                child: Text(
                                  chat.text,
                                  style: TextStyle(
                                    color: ColorManager.blueGrey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            chat.time,
                            style: TextStyle(
                              color: ColorManager.gery,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: heightScreen / 90, //5.0
                          ),
                      /*    chat.unread
                              ? Container(
                                  width: widthScreen / 12,//25 //new Change
                                  //40.0
                                  height: heightScreen / 40,
                                  //20.0
                                  decoration: BoxDecoration(
                                    color: ColorManager.primary,
                                    borderRadius: BorderRadius.circular(
                                      30.0,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'NEW'.tr(context),
                                    style: TextStyle(
                                      color: ColorManager.white,
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),*/
                        ],
                      ),
                    ],
                  ),
                ) : Container(),
              );
            },
          ),
        ),
      ),
    );
  },
);
  }
}
