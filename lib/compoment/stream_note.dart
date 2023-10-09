import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:widgets_basic/todolist/todolist_screen.dart'; // Import ToDoListScreen
import 'firestore.dart';

// ignore: must_be_immutable
class StreamNote extends StatelessWidget {
  bool done;
  StreamNote(this.done, {Key? key}) : super(key: key); // Added Key parameter

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore_Datasource().stream(done),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }
        final noteslist = Firestore_Datasource().getNotes(snapshot);
        return ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final note = noteslist[index];
            return Dismissible(
              key: UniqueKey(),
              onDismissed: (direction) {
                Firestore_Datasource().delet_note(note.id);
              },
              child: ToDoListScreen(note: note), // Pass the Note object to ToDoListScreen
            );
          },
          itemCount: noteslist.length,
        );
      },
    );
  }
}
