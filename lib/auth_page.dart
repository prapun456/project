import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:widgets_basic/sign_in/login_screen.dart';

import 'todolist/todolist_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return  ToDoListScreen();
            } else {
              return const SignInScreen();
            }
          }
        },
      ),
    );
  }
}
