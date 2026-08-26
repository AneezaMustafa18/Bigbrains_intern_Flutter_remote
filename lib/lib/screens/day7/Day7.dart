import 'package:bigbrains_day3/screens/day7/todo_tile.dart';
import 'package:flutter/material.dart';

class Day7 extends StatefulWidget {
  Day7({super.key ,});

  @override
  State<Day7> createState() => _Day7State();
}

class _Day7State extends State<Day7> {
  bool isTracker = false;
  // void onChanged(){
  // setState(() {
  // if(isTracker==false)
  // {
  //   isTracker= true;
  // }
  // else
  //   {
  //     isTracker = false;
  //   }
  // });
  // }

  void onChanged(int index){
    setState(() {
      notes[index][1];
      notes[index][1] = !notes[index][1];
    });

}

  List<List<dynamic>> notes =
      [
        ['Bug bhi fix krna hai:(',true],
        ['Error samajhna hai:(',false],
        ['Code run karna hai ',true],
        ['Ek aur bug aa gaya',true],
        ['Console check karna hai',false],
        ['Git push karna hai',true],
        ['Ye error jaa kyun nahi raha',true],
        ['Bas ek error fix karni hai',false],
        ['Ugh!! Chai peeni hai',true]
      ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Day 7_TodoTile',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
            ),
          ),
          backgroundColor: Colors.blueAccent.shade200,
          foregroundColor: Colors.white,
        ),
        body: ListView.builder(scrollDirection: Axis.vertical,itemCount: notes.length,itemBuilder: (context,index){
          return TodoTile(value: notes[index][1], onChanged: (value){onChanged(index);
          }, title: notes[index][0],);
        }),
      ),
    );
  }
}
