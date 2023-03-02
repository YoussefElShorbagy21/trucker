import 'package:flutter/material.dart';

import '../../shared/style/color_manager.dart';
import 'chat_widgets/favourite_contacts.dart';
import 'chat_widgets/recent_chats.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({Key? key}) : super(key: key);

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorManager.black,
      // Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: ColorManager.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          iconSize: 30.0,
          color: ColorManager.white,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Chats',
          style: TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search),
            iconSize: 30.0,
            color: ColorManager.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          // CategorySelector(),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: ColorManager.accentColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: const <Widget>[
                  FavouriteContacts(),
                  RecentChats(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
