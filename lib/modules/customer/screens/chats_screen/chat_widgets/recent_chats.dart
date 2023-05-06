import 'package:flutter/material.dart';
import 'package:login/modules/customer/screens/chats_screen/test_chat_screen.dart';
import 'package:login/shared/resources/app_localizations.dart';
import '../../../../../models/chat_model/message_model.dart';
import '../../../../../shared/resources/color_manager.dart';
import '../chat_screen.dart';

class RecentChats extends StatelessWidget {
  const RecentChats({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    double heightScreen = MediaQuery.of(context).size.height;

    return Expanded(
      child: Container(
        // height: heightScreen/3,
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
            itemCount: chats.length,
            itemBuilder: (BuildContext context, int index) {
              final Message chat = chats[index];

              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    // builder: (_) => ChatScreen(user: chat.sender),
                    builder: (_) => TestChatScreen(user: chat.sender,),
                  ),
                ),
                child: Container(
                  margin: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 5.0,
                    right: 20.0,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    // color: chat.unread
                    //     ? ColorManager.gery.withOpacity(0.3)
                    //     : ColorManager.white,
                    borderRadius: const BorderRadius.only(
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
                            radius: 35.0,
                            backgroundImage: AssetImage(chat.sender.imageUrl),
                          ),
                          SizedBox(
                            width: widthScreen / 40, //10.0
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                chat.sender.name,
                                style: TextStyle(
                                  color: ColorManager.gery,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: heightScreen / 90, //5.0
                              ),
                              Container(
                                width: widthScreen / 2, //6 normal//new Change
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
                          chat.unread
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
                              : const SizedBox.shrink(),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
