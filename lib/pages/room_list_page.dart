import 'package:chat_group/pages/add_room_page.dart';
import 'package:chat_group/pages/message_list_page.dart';
import 'package:chat_group/view_models/add_room_view_model.dart';
import 'package:chat_group/view_models/room_list_view_model.dart';
import 'package:chat_group/view_models/room_viewmodel.dart';
import 'package:chat_group/widgets/room_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RoomListPage extends StatefulWidget {
  @override
  _RoomListPage createState() => _RoomListPage();
}

class _RoomListPage extends State<RoomListPage> {
  roomListViewModel _listViewModel = roomListViewModel();
  List<RoomViewmodel> _rooms = [];
  @override
  void initState() {
    super.initState();
    _populateRooms();
  }

  void _populateRooms() async {
    final rooms = await _listViewModel.getAllRoom();
    setState(() {
      _rooms = rooms;
    });
  }

  void _navigateToAddRoomPage(BuildContext context) async {
    bool roomAdded = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
                  create: (context) => AddRoomViewmodel(),
                  child: AddRoomPage(),
                ),
            fullscreenDialog: true));
    if (roomAdded != null && roomAdded) {
      _populateRooms();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Rooms"),
          actions: [
            GestureDetector(
                onTap: () {
                  _navigateToAddRoomPage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.add),
                ))
          ],
        ),
        body: RoomList(
          rooms: _rooms,
          onRoomSelected: (room) {
            _navigateToMessagesByRoom(room, context);
          },
        ));
  }

  _navigateToMessagesByRoom(RoomViewmodel room, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MessageListPage(room: room);
    }));
  }
}
