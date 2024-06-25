// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // RECENT MEMORIES
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Recent Memories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 200, // Set height
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Image.asset('assets/hiking.jpg', fit: BoxFit.cover),
                  ),
                  Expanded(
                    child: Image.asset('assets/fishing.jpg', fit: BoxFit.cover),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30), // Space between sections

            // NEWEST ACTIVITY
            Container(
              padding: EdgeInsets.all(20),
              color: Colors.orange[200], // Color for the container background
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Newest Activity',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(
                      'Dinner at 5 PM Today\nMeet Matt at French Workshop\nRSVP',
                      style: TextStyle(fontSize: 16)),
                  Text('Pete Accepted your request to Dinner June 14',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),

            SizedBox(height: 30), // Space between sections

            // TRENDS
            Container(
              padding: const EdgeInsets.all(20),
              color: Colors.yellow[200], // Color for the container background
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Trends',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text('Completed five more plans this month\nKeep It Up',
                      style: TextStyle(fontSize: 16)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
