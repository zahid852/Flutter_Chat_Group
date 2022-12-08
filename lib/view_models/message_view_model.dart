import 'package:chat_group/models/message.dart';
import 'package:chat_group/widgets/message.dart';
import 'package:intl/intl.dart';

class MessageViewModel {
  final MessageModel message;
  MessageViewModel({required this.message});
  String get messageText {
    return message.text;
  }

  String get username {
    return message.username;
  }

  String get date {
    return DateFormat('MM-dd-yyyy').format(message.dateCreated);
  }
}
