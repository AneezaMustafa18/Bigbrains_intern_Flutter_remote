import 'package:bigbrains_day3/screens/day7/MyText.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  TodoTile ({super.key ,required this.value ,required this.onChanged ,required this.title});
  bool value;
  String title;

  void Function(bool?)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlue.shade100,
          borderRadius: BorderRadius.circular(50),
        ),
        height: 65,
        width: 400,
        child:
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start
            ,
            children: [
              Checkbox(value: value, onChanged: onChanged,
              activeColor: Colors.grey,
              checkColor: Colors.black,),
              Center(

                child: Mytext(title: title, check: value ,),
              )
            ],
          ),
        ),
      ),
    );
  }
}
