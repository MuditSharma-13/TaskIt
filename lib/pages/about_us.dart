import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 75.0),
          child: Text('About Us'),
        ),
      ),
      body: Center(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Text(
              "Hello. I'm Mudit Sharma, the creator of Taskit, your personal To-do App. \n\nI'm currently pursuing Masters in Economics at BITS Pilani, Pilani campus.",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
}
