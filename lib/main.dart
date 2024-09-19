import 'package:chat_app/views/chat.dart';
import 'package:chat_app/views/home.dart';
import 'package:chat_app/views/profile.dart';
import 'package:chat_app/views/search_user.dart';
import 'package:chat_app/views/update_profile.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat Application',
      routes: {
        // "/": (context) => const PhoneLogin(),
        "/": (context) => const HomePage(),
        "/chat": (context) => const Chat(),
        "/profile": (context) => const Profile(),
        "/update-profile": (context) => const UpdateProfile(),
        "/search": (context) => const SearchUser(),
      },
    );
  }
}
