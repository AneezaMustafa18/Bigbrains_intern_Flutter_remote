import 'package:bigbrains_day3/screens/day7/todo_tile.dart' show TodoTile;

import 'package:flutter/material.dart';

class Day8 extends StatefulWidget {
  Day8({super.key ,});


  @override
  State<Day8> createState() => _Day8State();
}

TextEditingController _controller = TextEditingController();

class _Day8State extends State<Day8> {
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
  //Todoo snackbar
  TodoSnackbar(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
          height: 200,width: 200,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
            TextFormField(
               controller:  _controller,
              decoration: InputDecoration(
                hintText: 'Enter Note Here ',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.lightBlue.shade50,
                  )
                )
              ),
            ),
              SizedBox(height: 15,),

              Row(
                children: [
                  SizedBox(width: 10,),
                 GestureDetector(
                    onTap: (){
                      setState(() {
                        notes.add([_controller.text.toString() ,false]);
                        Navigator.pop(context);
                        _controller.clear();
                      });

                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text('Add',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),
                  ),
                  SizedBox(width: 20,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade800,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Center(
                        child: Text('Cancel',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      );
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
        floatingActionButton: FloatingActionButton(onPressed: (){TodoSnackbar();},
        child: Icon(Icons.add),hoverColor: Colors.lightBlue.shade400,focusColor: Colors.lightBlue.shade200,foregroundColor: Colors.black,),
        appBar: AppBar(
          title: Center(
            child: Text('Day 8_TodoTile',
              style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
            ),
          ),
          backgroundColor: Colors.blueAccent.shade200,
          foregroundColor: Colors.black,
        ),
        body: ListView.builder(scrollDirection: Axis.vertical,itemCount: notes.length,itemBuilder: (context,index){
          return TodoTile(value: notes[index][1], onChanged: (value){onChanged(index);
          }, title: notes[index][0], onDelete: () {  },);
        }),
      ),
    );
  }
}
