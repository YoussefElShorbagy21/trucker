import 'package:flutter/material.dart';

import '../../../models/chat_model/message_model.dart';
import '../../../models/chat_model/user_model.dart';
import '../../../shared/resources/color_manager.dart';


class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorManager.white,
        title: Text(
          widget.user.name,
          style: const TextStyle(
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: ColorManager.black,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
          children: <Widget>[
            Expanded(
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
                    topLeft: Radius.circular(
                      30.0,
                    ),
                    topRight: Radius.circular(
                      30.0,
                    ),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: const EdgeInsets.only(
                      top: 15.0,
                    ),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      final bool isMe = message.sender.id == currentUser.id;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageCompose(),
          ],
        ),
      ),
    );
  }

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : const EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              // right: 80.0,
            ),
      padding: const EdgeInsets.symmetric(
        horizontal: 25.0,
        vertical: 15.0,
      ),
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
        color: isMe
             ? ColorManager.accentColor//Theme.of(context).colorScheme.secondary
            : ColorManager.tinyPink,
        borderRadius: isMe
            ? const BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : const BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
              color: ColorManager.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            message.text,
            style: TextStyle(
              color: ColorManager.blueGrey,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
    if (isMe) {
      return msg;
    }
    return Row(
      children: [
        msg,
        IconButton(
          icon: message.isLiked
              ? const Icon(Icons.favorite)
              : const Icon(Icons.favorite_border),
          iconSize: 30.0,
          color: message.isLiked ? ColorManager.primary : ColorManager.blueGrey,
          onPressed: () {},
        ),
      ],
    );
  }

  _buildMessageCompose() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      height: MediaQuery.of(context).size.height / 10,
      color: ColorManager.white,
      child: Row(
        children: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.photo,
            ),
            iconSize: 25.0,
            color: ColorManager.black,
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value){},
              decoration: const InputDecoration(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.send,
            ),
            iconSize: 25.0,
            color: ColorManager.black,
          ),
        ],
      ),
    );
  }
}
