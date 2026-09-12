import 'package:bigbrains_day3/screens/day7/todo_tile.dart' show TodoTile;
import 'package:bigbrains_day3/screens/day9/todo_dialog.dart';
import 'package:flutter/material.dart';

class Day9 extends StatefulWidget {
  Day9({
    super.key,
  });

  @override
  State<Day9> createState() => _Day8State();
}

class _Day8State extends State<Day9> {
  bool isTracker = false;

  void onChanged(int index) {
    setState(() {
      notes[index][1];
      notes[index][1] = !notes[index][1];
    });
  }

  // Delete Todo
  void deleteTodo(int index) {
    setState(() {
      notes.removeAt(index);
    });
  }

  List<List<dynamic>> notes = [
    ['Bug bhi fix krna hai:(', true],
    ['Error samajhna hai:(', false],
    ['Code run karna hai ', true],
    ['Ek aur bug aa gaya', true],
    ['Console check karna hai', false],
    ['Git push karna hai', true],
    ['Ye error jaa kyun nahi raha', true],
    ['Bas ek error fix karni hai', false],
    ['Ugh!! Chai peeni hai', true]
  ];

  // Add Todo Dialog
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            TodoSnackbar();
          },
          child: Icon(Icons.add),
          hoverColor: Colors.lightBlue.shade400,
          focusColor: Colors.lightBlue.shade200,
          foregroundColor: Colors.black,
        ),

        appBar: AppBar(
          title: Center(
            child: Text(
              'Day 9_TodoTile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          backgroundColor: Colors.blueAccent.shade200,
          foregroundColor: Colors.black,
        ),

        body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return TodoTile(
              value: notes[index][1],

              // Checkbox
              onChanged: (value) {
                onChanged(index);
              },

              // Todo title
              title: notes[index][0],

              // Delete button
              onDelete: () {
                deleteTodo(index);
              },
            );
          },

        ),
        // Fixed bottom text
        bottomNavigationBar: Container(
          height: 55,
          color: Colors.blueAccent.shade200,
          child: Center(
            child: Text(
              "Aneeza's Daily Notes",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

      ),
    );
  }
}