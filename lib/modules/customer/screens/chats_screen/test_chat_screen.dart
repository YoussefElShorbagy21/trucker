import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/models/chat_model/message_model.dart';
import 'package:login/shared/resources/color_manager.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../../shared/components/chat_style.dart';

class TestChatScreen extends StatefulWidget {

   TestChatScreen({Key? key,}) : super(key: key);
  @override
  State<TestChatScreen> createState() => _TestChatScreenState();
}
TextEditingController controller = TextEditingController();
class _TestChatScreenState extends State<TestChatScreen> {
  late IO.Socket socket ;
  List<String> messages = [];

  @override
  void initState() {
    connect(socket);
    socket.on('message', (data) {
      setState(() {
        messages.add(data['text']);
      });
    });
    socket.on('disconnect', (_) => print('Disconnected'));
    super.initState();
  }
  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  sendMessage(String message) {
    socket.emit('client message', {
      'sender': "649885d71f045d12677c3fbc",
      'receiver': "64955dac39fd991f877f27a0",
      'msg': message,
    });
    controller.clear();
  }
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
        title: const Text('Support Team'),
       /* actions: [
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
        ],*/
      ),
      body:   Column(
        children: [
          const Expanded(
            child: _DemoMessageList(),
          ),
          _ActionBar(onPressed: sendMessage(controller.text),),
        ],
      ),
    );
  }
}

//all message
class _DemoMessageList extends StatelessWidget {
  const _DemoMessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: ListView(
        children:  [
          _MessageUserTile(),
          _MessageSupportTile(),
        ],
      ),
    );
  }
}

//Send message
class _ActionBar extends StatelessWidget {
  void Function()? onPressed ;
  _ActionBar({Key? key,required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      top: false,
      child: Row(
        children: [
        /*  Container(
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
          ),*/
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
              onPressed: onPressed,
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

//support team
class _MessageSupportTile extends StatelessWidget {

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
                  message?.text??'are you trucker',
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

//message user
class _MessageUserTile extends StatelessWidget {
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
                child: Text(message?.text ?? 'hello customer',
                  style: const TextStyle(
                    color: ColorManager.textLigth,
                  ),
                ),
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

//Time send
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

void connect(socket){
  socket = IO.io('client message', <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': false,
  });
  socket.connect();

}