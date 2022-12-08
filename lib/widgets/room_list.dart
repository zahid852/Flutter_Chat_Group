import 'package:chat_group/view_models/room_viewmodel.dart';
import 'package:flutter/material.dart';

class RoomList extends StatelessWidget {
  final List<RoomViewmodel> rooms;
  Function(RoomViewmodel)? onRoomSelected;
  RoomList({required this.rooms, this.onRoomSelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          final room = rooms[index];
          return ListTile(
            title: Text(room.title),
            trailing: Icon(Icons.arrow_forward_ios),
            subtitle: Text(room.des),
            onTap: () {
              onRoomSelected!(room);
            },
          );
        });
  }
}
