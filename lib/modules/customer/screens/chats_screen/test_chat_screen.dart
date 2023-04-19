import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/chat_model/message_model.dart';
import 'package:login/shared/resources/color_manager.dart';
import '../../../../models/chat_model/test_chat_model.dart';
import '../../../../models/chat_model/user_model.dart';
import '../../../../shared/components/chat_style.dart';

class TestChatScreen extends StatefulWidget {
  // static Route route(MessageData data) => MaterialPageRoute(
  //       builder: (context) => TestChatScreen(
  //         messageData: data,
  //       ),
  //     );

  const TestChatScreen({Key? key, required this.user,}) : super(key: key);

  // final MessageData messageData;
  final User user;

  @override
  State<TestChatScreen> createState() => _TestChatScreenState();
}

class _TestChatScreenState extends State<TestChatScreen> {
  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.user.name),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Center(
                child: IconBorder(
              icon: CupertinoIcons.video_camera_solid,
              onTap: () {},
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Center(
                child: IconBorder(
              icon: CupertinoIcons.phone_solid,
              onTap: () {},
            )),
          ),
        ],
      ),
      body: const Column(
        children: [
          Expanded(
            child: _DemoMessageList(),
          ),
          _ActionBar(),
        ],
      ),
    );
  }
}

class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children:  [
          _DateLabel(label: 'Yesterday'),
          _MessageTile(
            // message: 'Hi, How\'s your day going?',
            // messageDate: '12:01 pm',
          ),
          _MessageOwnTile(
            // message: 'it\'s fine',
            // messageDate: '12:05 pm',
          ),
          _MessageTile(
            // message: 'Do you want to rent my truck',
            // messageDate: '12:10 pm',
          ),
          // _MessageOwnTile(
          //   message: 'yes, I want for sure',
          //   messageDate: '12:12 pm',
          // ),
          _MessageOwnTile(),
        ],
      ),
    );
  }
}

class _ActionBar extends StatelessWidget {
  const _ActionBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  width: 2,
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Icon(
                CupertinoIcons.camera_fill,
              ),
            ),
          ),
          const Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: TextField(
                style: TextStyle(
                  fontSize: 14.0,
                ),
                decoration: InputDecoration(
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
              onPressed: () {},
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

class _MessageOwnTile extends StatelessWidget {


  // final String message;
  // final String messageDate;
   Message? message;

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
              decoration: const BoxDecoration(
                color: Color(0xFF3B76F6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                  bottomLeft: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 20.0),
                child: Text(
                  message?.text??'are you trucker',
                  style: const TextStyle(
                    color: ColorManager.textLigth,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                message?.time??'1:30pm',
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

class _MessageTile extends StatelessWidget {


  // final String message;
  // final String messageDate;
   Message? message;

  static const _borderRadius = 26.0;

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
              decoration: BoxDecoration(
                color: ColorManager.gery.withOpacity(0.1),
                // color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(_borderRadius),
                  topRight: Radius.circular(_borderRadius),
                  bottomRight: Radius.circular(_borderRadius),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 20.0),
                child: Text(message?.text ?? 'hello customer'),
              ),
            ),
            Text(
              message?.time??'12:30',
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

class _DateLabel extends StatelessWidget {
  const _DateLabel({Key? key, required this.label}) : super(key: key);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
                color: ColorManager.textFaded,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// class _AppBarTitle extends StatelessWidget {
//   const _AppBarTitle({Key? key, required this.messageData}) : super(key: key);
//
//   final MessageData messageData;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Avatar.small(
//           url: messageData.profilePicture,
//         ),
//         const SizedBox(
//           width: 16.0,
//         ),
//         Expanded(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 messageData.senderName,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(fontSize: 14.0),
//               ),
//               const SizedBox(
//                 height: 2,
//               ),
//               const Text(
//                 'Online now',
//                 style: TextStyle(
//                   fontSize: 10.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }
