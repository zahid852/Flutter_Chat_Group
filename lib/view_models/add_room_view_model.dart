import 'package:chat_group/models/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class AddRoomViewmodel extends ChangeNotifier {
  Future<bool> addRoom(String title, String des) async {
    String message = '';
    bool isSaved = false;
    try {
      final room = Room(roomName: title, description: des);
      await FirebaseFirestore.instance.collection('rooms').add(room.toMap());
      isSaved = true;
    } catch (e) {
      message = 'Error adding a room';
    }
    notifyListeners();
    return isSaved;
  }
}
