import 'package:flutter/material.dart';



class Day3 extends StatelessWidget {
  const Day3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Padding(padding: EdgeInsets.all(20),
        child:Column(
          children: [
            Stack(alignment: Alignment.center,
              children: [
                Center(
                  child: Container(
                    height: 130,
                    width: 130,
                    decoration: BoxDecoration(
                      color: Colors.blue.shade800,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                const Icon(Icons.person,
                  size: 70,
                  color: Colors.blueAccent,)
              ],
            ),
            const SizedBox(height: 15,),
            const Text('Aneeza Mustafa :)',
              style: TextStyle(fontSize: 26,
                  fontWeight: FontWeight.bold),),

            const SizedBox(height: 5),

            // Designation
            const Text(
              "Flutter Intern at BigBrains",
              style: TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.blue,
                    size: 30,
                  ),

                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Email',
                          style: TextStyle(fontSize: 17,
                            fontWeight: FontWeight.bold,)
                      ),
                      Text('aneezamustafa18@gmail.com',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),

                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.blue,
                    size: 30,
                  ),

                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Phone',
                          style: TextStyle(fontSize: 17,
                            fontWeight: FontWeight.bold,)
                      ),
                      Text('+92 3XX XXXXXXX',
                        style: TextStyle(
                          fontSize: 15,
                        ),),
                    ],
                  ),

                ],
              ),
            ),
            const SizedBox(height: 30),
            InkWell(
              onTap: (){},
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 30,
                    ),

                    const SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Edit profile',
                            style: TextStyle(fontSize: 17,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,)
                        ),

                      ],
                    ),

                  ],
                ),
              ),
            ),


          ],
        ),

      ),
    );
  }
}



