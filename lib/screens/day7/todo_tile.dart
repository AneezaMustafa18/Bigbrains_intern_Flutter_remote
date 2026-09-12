import 'package:bigbrains_day3/screens/day7/MyText.dart';
import 'package:flutter/material.dart';

class TodoTile extends StatelessWidget {
  TodoTile({
    super.key,
    required this.value,
    required this.onChanged,
    required this.title,
    required this.onDelete,
  });

  bool value;
  String title;

  // Delete function
  VoidCallback onDelete;

  void Function(bool?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        children: [

          // Todo Container
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue.shade100,
                borderRadius: BorderRadius.circular(50),
              ),
              height: 70,
              width: 150,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Checkbox(
                      value: value,
                      onChanged: onChanged,
                      activeColor: Colors.grey,
                      checkColor: Colors.black,
                    ),

                    Expanded(
                      child: Mytext(
                        title: title,
                        check: value,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(width: 10),

          // Separate Delete Button
          SizedBox(
            height: 55,
            width: 120,
            child: ElevatedButton.icon(
              onPressed: onDelete,
              icon: Icon(
                Icons.delete,
                size: 20
              ),
              label: Text(
                'Delete',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent.shade200,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}