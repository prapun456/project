import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:widgets_basic/add_note_screen.dart';
import 'package:widgets_basic/sign_in/login_screen.dart';
import 'package:widgets_basic/compoment/firestore.dart';
import 'package:widgets_basic/compoment/stream_note.dart';
import 'package:widgets_basic/compoment/note_model.dart';


class ToDoListScreen extends StatefulWidget {
  final Note? note; // Define the Note object as a parameter (nullable)

  ToDoListScreen({this.note, Key? key}) : super(key: key);

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  final user = FirebaseAuth.instance.currentUser;
  bool show = true;

  //sign user in method
  void signOutUser() async {
    await FirebaseAuth.instance.signOut();
    const SignInScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade500,
        centerTitle: true,
        title: Text(
          "Task management.",
          textAlign: TextAlign.center,
          style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.displayLarge,
            fontSize: 24,
            fontWeight: FontWeight.w700,
            fontStyle: FontStyle.normal,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: signOutUser,
            icon: const Icon(
              Icons.login,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      floatingActionButton: Visibility(
        visible: show,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddNoteScreen()));
          },
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
      body: SafeArea(
        child: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              setState(() {
                show = true;
              });
            }
            if (notification.direction == ScrollDirection.reverse) {
              setState(() {
                show = false;
              });
            }
            return true;
          },
          child: Column(
            children: [
              StreamNote(false),
              Text(
                'isDone',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade500,
                    fontWeight: FontWeight.bold),
              ),
              StreamNote(true),
            ],
          ),
        ),
      ),
    );
  }
}
