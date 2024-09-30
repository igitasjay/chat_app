import 'package:chat_app/controllers/appwrite_controllers.dart';
import 'package:chat_app/controllers/local_saved_data.dart';
import 'package:chat_app/providers/user_data_provider.dart';
import 'package:chat_app/views/chat.dart';
import 'package:chat_app/views/home.dart';
import 'package:chat_app/views/phone_login.dart';
import 'package:chat_app/views/profile.dart';
import 'package:chat_app/views/search_user.dart';
import 'package:chat_app/views/update_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalSavedData.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDataProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        title: 'Chat Application',
        routes: {
          "/": (context) => const CheckUserSession(),
          "/login": (context) => const PhoneLogin(),
          "/home": (context) => const HomePage(),
          "/chat": (context) => const Chat(),
          "/profile": (context) => const Profile(),
          "/update": (context) => const UpdateProfile(),
          "/search": (context) => const SearchUser(),
        },
      ),
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
        Navigator.pushNamedAndRemoveUntil(context, "/update", (route) => false,
            arguments: {"title": "add"});
      } else {
        if (mounted) {
          Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false);
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
