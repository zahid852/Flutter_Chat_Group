import 'package:chat_group/models/room.dart';
import 'package:chat_group/view_models/room_viewmodel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class roomListViewModel {
  Future<List<RoomViewmodel>> getAllRoom() async {
    final QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('rooms').get();
    final rooms = snapshot.docs.map((e) => Room.fromSnapshot(e)).toList();
    return rooms.map((e) => RoomViewmodel(room: e)).toList();
  }
}
