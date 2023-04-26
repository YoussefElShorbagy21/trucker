import 'package:login/shared/resources/asset_manager.dart';

import 'user_model.dart';

class Message {
  final User sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;

  Message({
    required this.sender,
    required this.time,
    required this.text,
    required this.isLiked,
    required this.unread,
  });
}

final User currentUser = User(
  id: 0,
  name: 'Current User',
  imageUrl: ImageAssets.kShorbagy,
);

final User Ahmed = User(
  id: 1,
  name: 'Ahmed',
  imageUrl: ImageAssets.kAhmed,
);

final User Shorbagy = User(
  id: 2,
  name: 'Shorbagy',
  imageUrl: ImageAssets.kShorbagy,
);

final User Joe = User(
  id: 3,
  name: 'Joe',
  imageUrl: ImageAssets.kGreg,
);

final User Abdulrahman = User(
  id: 4,
  name: 'Abdulrahman',
  imageUrl: ImageAssets.kAbdulrahman,
);

final User AhmedMohamed = User(
  id: 5,
  name: 'Ahmed',
  imageUrl: ImageAssets.kAhmed,
);

final User Youssef = User(
  id: 1,
  name: 'Youssef Alaa',
  imageUrl: ImageAssets.kYoussef,
);

final User Abdo = User(
  id: 1,
  name: 'Abdulrahman',
  imageUrl: ImageAssets.kAbdulrahman,
);

//Favorite Contacts
List<User> favorites = [Shorbagy, Youssef, Ahmed, Abdo, Joe];

//Example chats on Home Screen
List<Message> chats = [
  Message(
    sender: Shorbagy,
    time: '5:30 PM',
    text: 'Hey, how\'s it going?, where are you now?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: Youssef,
    time: '4:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: Ahmed,
    time: '3:30 PM',
    text: 'Hey, how\'re you?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: Abdo,
    time: '2:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: Joe,
    time: '1:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: Ahmed,
    time: '12:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: Abdulrahman,
    time: '11:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
];
List<Message> messages = [
  Message(
    sender: Shorbagy,
    time: '5:30 PM',
    text: 'Hey, how\'s it going?, where are you now?',
    isLiked: true,
    unread: false,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'just walked my dog ,where would you wanna to meet?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: Youssef,
    time: '3:45 PM',
    text: 'How\'s the dog?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: Abdulrahman,
    time: '3:15 PM',
    text: 'All the food',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! what kind of food did you eat?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: Ahmed,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
