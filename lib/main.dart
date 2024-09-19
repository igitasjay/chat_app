import 'package:chat_app/controllers/appwrite_controllers.dart';
import 'package:chat_app/views/chat.dart';
import 'package:chat_app/views/home.dart';
import 'package:chat_app/views/phone_login.dart';
import 'package:chat_app/views/profile.dart';
import 'package:chat_app/views/search_user.dart';
import 'package:chat_app/views/update_profile.dart';
import 'package:flutter/cupertino.dart';
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
        "/": (context) => const CheckUserSession(),
        "/login": (context) => const PhoneLogin(),
        "/home": (context) => const HomePage(),
        "/chat": (context) => const Chat(),
        "/profile": (context) => const Profile(),
        "/update-profile": (context) => const UpdateProfile(),
        "/search": (context) => const SearchUser(),
      },
    );
  }
}

class CheckUserSession extends StatefulWidget {
  const CheckUserSession({super.key});

  @override
  State<CheckUserSession> createState() => CheckUserSessionState();
}

class CheckUserSessionState extends State<CheckUserSession> {
  @override
  void initState() {
    checkSessions().then((value) {
      if (value && mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        if (mounted) {
          Navigator.pushNamed(context, "/login");
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CupertinoActivityIndicator()),
    );
  }
}
