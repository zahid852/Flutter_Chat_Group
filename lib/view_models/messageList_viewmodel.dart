import 'dart:async';
import 'dart:developer';

import 'package:chat_group/models/message.dart';
import 'package:chat_group/view_models/message_view_model.dart';
import 'package:chat_group/view_models/room_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageListViewModel {
  final RoomViewmodel room;
  final StreamController<List<MessageViewModel>> messagesStream =
      StreamController();
  MessageListViewModel({required this.room}) {
    _subscribeToMessageStream();
  }

  void _subscribeToMessageStream() {
    try {
      FirebaseFirestore.instance
          .collection('messages')
          .where('roomId', isEqualTo: room.roomId)
          .orderBy('dateCreated', descending: false)
          .snapshots()
          .listen((data) {
        final messages =
            data.docs.map((doc) => MessageModel.fromSnapshot(doc)).toList();
        final messageViewModel = messages
            .map((message) => MessageViewModel(message: message))
            .toList();

        messagesStream.sink.add(messageViewModel);
      });
    } catch (e) {
      log('in function $e');
    }
  }

  Future<bool> sendMessage(
      String roomId, String messageText, String username) async {
    bool isSaved = false;
    final message = MessageModel(
        roomId: roomId,
        text: messageText,
        username: username,
        dateCreated: DateTime.now());
    try {
      await FirebaseFirestore.instance
          .collection('messages')
          .add(message.toMap());
      isSaved = true;
    } catch (errro) {}
    return isSaved;
  }
}
