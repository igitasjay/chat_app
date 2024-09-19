import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: ListView(
        children: [
          ListTile(
            leading: CircleAvatar(
                backgroundImage:
                    const Image(image: AssetImage("assets/user.png")).image),
            title: const Text("John Doe"),
            subtitle: const Text("+2349024492577"),
            trailing: IconButton(
              onPressed: () {
                Navigator.pushNamed(context, "/update-profile");
              },
              icon: const Icon(Icons.edit),
            ),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.logout),
            title: Text("Log out"),
          ),
          const Divider(),
          const ListTile(
            leading: Icon(Icons.info),
            title: Text("About"),
          ),
        ],
      ),
    );
  }
}
