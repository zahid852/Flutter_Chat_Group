import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageModel {
  String? messageId;
  final String roomId;
  final String text;
  final String username;
  final DateTime dateCreated;
  MessageModel(
      {this.messageId,
      required this.roomId,
      required this.text,
      required this.username,
      required this.dateCreated});
  Map<String, dynamic> toMap() {
    return {
      'roomId': roomId,
      'text': text,
      'username': username,
      'dateCreated': dateCreated
    };
  }

  factory MessageModel.fromSnapshot(QueryDocumentSnapshot doc) {
    return MessageModel(
        messageId: doc.id,
        roomId: doc['roomId'],
        text: doc['text'],
        username: doc['username'],
        dateCreated: doc['dateCreated'].toDate());
  }
}
