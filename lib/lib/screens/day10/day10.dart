import 'package:bigbrains_day3/screens/day10/about_me.dart' show AboutMe;
import 'package:bigbrains_day3/screens/day10/my_journey.dart';
import 'package:bigbrains_day3/screens/day10/my_skills.dart';
import 'package:bigbrains_day3/screens/day7/todo_tile.dart';
import 'package:bigbrains_day3/screens/day9/todo_dialog.dart';

import 'package:flutter/material.dart';

class Day10 extends StatefulWidget {
  const Day10({super.key});

  @override
  State<Day10> createState() => _Day10State();
}

class _Day10State extends State<Day10> {
  // Checkbox functionality
  void onChanged(int index) {
    setState(() {
      notes[index][1] = !notes[index][1];
    });
  }

  // DeleteTodo functionality
  void deleteTodo(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  // TodoList
  List<List<dynamic>> notes = [
    ['Bug bhi fix krna hai:(', true],
    ['Error samajhna hai:(', false],
    ['Code run karna hai', true],
    ['Ek aur bug aa gaya', true],
    ['Console check karna hai', false],
    ['Git push karna hai', true],
    ['Ye error jaa kyun nahi raha', true],
    ['Bas ek error fix karni hai', false],
    ['Ugh!! Chai peeni hai', true],
  ];

  // Add TodoDialog
  void TodoSnackbar() {
    showDialog(
      context: context,
      builder: (context) {
        return TodoDialog(
          onAdd: (String todo) {
            setState(() {
              notes.add([todo, false]);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        // Drawer
        drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [

              // Drawer Header
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blueAccent.shade200,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/profile.png',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    SizedBox(height: 10),

                    Text(
                      "Aneeza's Daily Notes",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),


              // About Me
              ListTile(
                leading: Icon(Icons.person),
                title: Text('About Me'),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutMe(),
                    ),
                  );
                },
              ),

// My Skills
              ListTile(
                leading: Icon(Icons.code),
                title: Text('My Skills'),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MySkills(),
                    ),
                  );
                },
              ),

// My Journey
              ListTile(
                leading: Icon(Icons.timeline),
                title: Text('My Journey'),
                onTap: () {
                  Navigator.pop(context);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyJourney(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),

        // AppBar
        appBar: AppBar(
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: Text(
            "Aneeza's Daily Notes",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.blueAccent.shade200,
          foregroundColor: Colors.black,
        ),

        // Add Button
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TodoSnackbar();
          },
          child: Icon(Icons.add),
          hoverColor: Colors.lightBlue.shade400,
          focusColor: Colors.lightBlue.shade200,
          foregroundColor: Colors.black,
        ),

        body: Column(
          children: [

            // Image Section
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                clipBehavior: Clip.hardEdge,
                child: Image.asset(
                  'assets/images/aneeza_coding.JPG',
                  fit: BoxFit.cover,
                ),
              ),
            ),

            // TodoList
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) {
                  return TodoTile(
                    value: notes[index][1],
                    onChanged: (value) {
                      onChanged(index);
                    },
                    title: notes[index][0],
                    onDelete: () {
                      deleteTodo(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),



      ),
    );
  }
}