import 'package:flutter/material.dart';

class MySkills extends StatelessWidget {
  const MySkills({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Skills',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent.shade200,
      ),
      body: ListView(
        padding: EdgeInsets.all(20),
        children: [
          ListTile(
            leading: Icon(Icons.phone_android),
            title: Text('Flutter'),
          ),
          ListTile(
            leading: Icon(Icons.code),
            title: Text('Dart'),
          ),
          ListTile(
            leading: Icon(Icons.cloud),
            title: Text('Firebase'),
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Firestore'),
          ),
          ListTile(
            leading: Icon(Icons.account_tree),
            title: Text('Provider / GetX'),
          ),
          ListTile(
            leading: Icon(Icons.api),
            title: Text('REST APIs'),
          ),
          ListTile(
            leading: Icon(Icons.storage),
            title: Text('Git & GitHub'),
          ),
        ],
      ),
    );
  }
}