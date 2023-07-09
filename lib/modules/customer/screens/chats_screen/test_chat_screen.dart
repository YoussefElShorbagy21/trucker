import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/layout/homeLayout/cubit/cubit.dart';
import 'package:login/layout/homeLayout/cubit/state.dart';
import 'package:login/shared/resources/color_manager.dart';
import '../../../../shared/components/chat_style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../shared/components/constants.dart';


class TestChatScreen extends StatelessWidget {
   const TestChatScreen({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
          HomeCubit.get(context).getMessage();
        return BlocConsumer<HomeCubit, HomeStates>(
  listener: (context, state) {
  },
  builder: (context, state) {
    return Scaffold(
          appBar: AppBar(
            iconTheme: Theme.of(context).iconTheme,
            centerTitle: false,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            leadingWidth: 54,
            leading: Align(
              alignment: Alignment.centerRight,
              child: IconBackground(
                icon: CupertinoIcons.back,
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            title: const Text('Support Team'),
          ),
          body:   Column(
            children: [
               Expanded(
                child: DemoMessageList(messages: HomeCubit.get(context).messages,),
              ),
              const _ActionBar(),
            ],
          ),
        );
  },
);
      }
    );
  }
}
TextEditingController controller = TextEditingController();



//all message
class DemoMessageList extends StatelessWidget {
  List<dynamic> messages ;
  DemoMessageList({Key? key,required this.messages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView.builder(
        itemBuilder: (context , index)
        {
          if(uid == messages[index]['senderId'])
          {
            return MessageUserTile(text:messages[index]['text'] ,
              time: messages[index]['dateTime'],);
          }
          else {
            return MessageSupportTile(text:messages[index]['text'] ,
                time: messages[index]['dateTime']);
          }
        },
        itemCount: messages.length,
      ),
    );
  }
}

//support team
class MessageSupportTile extends StatelessWidget {
  String text ;
  String time ;
  MessageSupportTile({super.key, required this.text ,required this.time});

  static const _borderRadius = 26.0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Align(
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              decoration:  BoxDecoration(
                color: ColorManager.gery.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 20.0),
                child: Text(
                  text,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                time,
                style: const TextStyle(
                  color: ColorManager.textFaded,
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//message user
class MessageUserTile extends StatelessWidget {

  String text ;
  String time ;
  static const _borderRadius = 26.0;
  MessageUserTile({super.key,required this.text,required this.time});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color(0xFF3B76F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 20.0),
                child: Text(text,
                  style: const TextStyle(
                    color: ColorManager.textLigth,
                  ),
                ),
              ),
            ),
            Text(
              time,
              style: const TextStyle(
                color: ColorManager.textFaded,
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
              ),

            ),
          ],
        ),
      ),
    );
  }
}

//Send message
class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: TextField(
                controller: controller,
                style: const TextStyle(
                  fontSize: 14.0,
                ),
                decoration: const InputDecoration(
                  hintText: 'Type Something',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 12.0,
              right: 24.0,
            ),
            child: IconButton(
              onPressed: (){
                HomeCubit.get(context).sendMessage(text: controller.text,
                name: HomeCubit.get(context).oneUserData.userData.name,
                  image: HomeCubit.get(context).oneUserData.userData.avatar
                );
                controller.clear();
              },
              icon: const Icon(
                Icons.send,
              ),
              iconSize: 25.0,
              color: ColorManager.black,
            ),
          )
        ],
      ),
    );
  }
}