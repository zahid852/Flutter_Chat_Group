import 'dart:async';
import 'dart:developer';

import 'package:chat_group/view_models/messageList_viewmodel.dart';
import 'package:chat_group/view_models/message_view_model.dart';
import 'package:chat_group/view_models/room_viewmodel.dart';
import 'package:chat_group/widgets/message.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageListPage extends StatefulWidget {
  final RoomViewmodel room;
  MessageListPage({required this.room});

  @override
  _MessageListPage createState() => _MessageListPage();
}

class _MessageListPage extends State<MessageListPage> {
  late MessageListViewModel _listViewModel;
  final _scrollController = ScrollController();
  final _messageTextController = TextEditingController();

  @override
  void initState() {
    _listViewModel = MessageListViewModel(room: widget.room);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage(BuildContext context) async {
    final messageText = _messageTextController.text;
    final sharedPreferences = await SharedPreferences.getInstance();
    final username = sharedPreferences.get('username') as String;
    if (messageText.isNotEmpty) {
      _messageTextController.clear();
      await _listViewModel.sendMessage(
          widget.room.roomId, messageText, username);
    }
  }

  Widget _buildMessageList(List<MessageViewModel> messages) {
    return Expanded(
        child: ListView.builder(
            controller: _scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              return Message(
                  messageText: message.messageText,
                  senderUserName: message.username);
            }));
  }

  void _scrolToBottom() {
    Timer(Duration(milliseconds: 500), () {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 1), curve: Curves.fastOutSlowIn);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.room.title)),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          StreamBuilder<List<MessageViewModel>>(
              stream: _listViewModel.messagesStream.stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error ${snapshot.error}');
                }
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading');

                  default:
                    if (!snapshot.hasData) {
                      return Text('No data');
                    }
                }
                snapshot.data!.map((e) => log(e.message.toString()));
                final messages = _buildMessageList(snapshot.data!);
                _scrolToBottom();
                return messages;
              }),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      decoration: InputDecoration(hintText: "Enter message"),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    color: Colors.green,
                    onPressed: () {
                      _sendMessage(context);
                    },
                  )
                ],
              ),
            ),
          )
        ]));
  }
}
