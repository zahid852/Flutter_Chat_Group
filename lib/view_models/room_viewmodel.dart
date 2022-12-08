import 'package:chat_group/models/room.dart';

class RoomViewmodel {
  final Room room;
  RoomViewmodel({
    required this.room,
  });
  String get roomId {
    return room.roomId!;
  }

  String get title {
    return room.roomName;
  }

  String get des {
    return room.description;
  }
}
