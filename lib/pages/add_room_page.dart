import 'package:chat_group/view_models/add_room_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddRoomPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  late AddRoomViewmodel addRoomViewmodel;
  void _saveRoom(BuildContext context) async {
    final title = _nameController.text;
    final des = _descriptionController.text;
    if (_formKey.currentState!.validate()) {
      final isSaved = await addRoomViewmodel.addRoom(title, des);
      if (isSaved) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    addRoomViewmodel = Provider.of<AddRoomViewmodel>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Add Room")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? "title is required" : null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Enter title"),
                  ),
                  TextFormField(
                    validator: (value) {
                      return value!.isEmpty ? "description is required" : null;
                    },
                    controller: _descriptionController,
                    decoration: InputDecoration(hintText: "Enter description"),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                      style: TextButton.styleFrom(backgroundColor: Colors.grey),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        _saveRoom(context);
                      },
                    ),
                  )
                ],
              )),
        ));
  }
}
