import 'package:truck_app/models/chat_model/user_model.dart';

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
  imageUrl: 'assets/images/chat_photo/greg.jpg',
);

final User greg = User(
  id: 1,
  name: 'Greg',
  imageUrl: 'assets/images/chat_photo/greg.jpg',
);

final User james = User(
  id: 2,
  name: 'James',
  imageUrl: 'assets/images/chat_photo/james.jpg',
);

final User john = User(
  id: 3,
  name: 'John',
  imageUrl: 'assets/images/chat_photo/john.jpg',
);

final User olivia = User(
  id: 4,
  name: 'Olivia',
  imageUrl: 'assets/images/chat_photo/olivia.jpg',
);

final User sam = User(
  id: 5,
  name: 'Sam',
  imageUrl: 'assets/images/chat_photo/sam.jpg',
);

final User sophia = User(
  id: 1,
  name: 'Sophia',
  imageUrl: 'assets/images/chat_photo/sophia.jpg',
);

final User steven = User(
  id: 1,
  name: 'Steven',
  imageUrl: 'assets/images/chat_photo/steven.jpg',
);

//Favorite Contacts
List<User> favorites = [sam, steven, olivia, john, greg];

//Example chats on Home Screen
List<Message> chats = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going?, where are you now?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text: 'Hey, how\'re you?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: greg,
    time: '11:30 PM',
    text: 'Hey, how\'s it going?',
    isLiked: false,
    unread: true,
  ),
];
List<Message> messages = [
  Message(
    sender: james,
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
    sender: james,
    time: '3:45 PM',
    text: 'How\'s the dog?',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: james,
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
    sender: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isLiked: false,
    unread: true,
  ),
];
