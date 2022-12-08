import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Room {
  String? roomId;
  final String roomName;
  final String description;
  Room({this.roomId, required this.roomName, required this.description});

  Map<String, dynamic> toMap() {
    return ({'RoomName': roomName, 'description': description});
  }

  factory Room.fromSnapshot(QueryDocumentSnapshot doc) {
    return Room(
        roomId: doc.id,
        roomName: doc['RoomName'],
        description: doc['description']);
  }
}
