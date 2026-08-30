import 'package:flutter/material.dart';

class MyJourney extends StatelessWidget {
  const MyJourney({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Journey',
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
            leading: Icon(Icons.flutter_dash),
            title: Text('Flutter Developer'),
            subtitle: Text(
              'Building mobile applications with Flutter and Dart for 3 years.',
            ),
          ),

          ListTile(
            leading: Icon(Icons.work),
            title: Text('Professional Experience'),
            subtitle: Text(
              'Gaining practical experience through projects, internships, and real-world development.',
            ),
          ),

          ListTile(
            leading: Icon(Icons.school),
            title: Text('Learning & Growing'),
            subtitle: Text(
              'Continuously exploring new concepts and improving my development skills.',
            ),
          ),

          ListTile(
            leading: Icon(Icons.rocket_launch),
            title: Text('Building Ideas'),
            subtitle: Text(
              'Turning ideas into mobile applications — if you dream it, I build it. 🚀',
            ),
          ),
        ],
      ),
    );
  }
}