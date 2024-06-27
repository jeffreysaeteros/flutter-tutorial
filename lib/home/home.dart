// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  // sample data
  final List<String> titles = [
    'Dinner at 5PM',
    'Lunch at 1PM',
    'Breakfast at 9AM',
  ];

  final List<String> subtitles = [
    'Meet John at the Grand',
    'Meet Alice at the Park',
    'Meet Bob at the Diner',
  ];

  final List<String> trendTitles = [
    'Dinner at 5PM',
    'Lunch at 1PM',
  ];

  final List<String> trendSubtitles = [
    'Meet John at the Grand',
    'Meet Alice at the Park',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 70),
        child: Column(
          children: <Widget>[
            // RECENT MEMORIES
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Recent Memories',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 200,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: const <Widget>[
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: MemoriesCard(cardName: 'Fishing')),
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: MemoriesCard(cardName: 'Fishing')),
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: MemoriesCard(cardName: 'Fishing')),
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: MemoriesCard(cardName: 'Fishing')),
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: MemoriesCard(cardName: 'Fishing')),
                    Card(
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: MemoriesCard(cardName: 'Fishing')),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30),

            // NEWEST ACTIVITY
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text('Newest Activity',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Container(
              height: 200,
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: NewestActivityCard(
                  titles: titles,
                  subtitles: subtitles,
                ),
              ),
            ),

            SizedBox(height: 30),

            // TRENDS
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text('Trends',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Container(
                child: Card(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: TrendsCard(
                  trendTitles: trendTitles, trendSubtitles: trendSubtitles),
            ))
          ],
        ),
      ),
    );
  }
}

class MemoriesCard extends StatelessWidget {
  const MemoriesCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 170,
      height: 170,
    );
  }
}

class NewestActivityCard extends StatelessWidget {
  const NewestActivityCard({
    Key? key,
    required this.titles,
    required this.subtitles,
  }) : super(key: key);

  final List<String> titles;
  final List<String> subtitles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(titles.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  titles[index],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  subtitles[index],
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

class TrendsCard extends StatelessWidget {
  const TrendsCard({
    Key? key,
    required this.trendTitles,
    required this.trendSubtitles,
  }) : super(key: key);

  final List<String> trendTitles;
  final List<String> trendSubtitles;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(trendTitles.length, (index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  trendTitles[index],
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  trendSubtitles[index],
                  style: TextStyle(fontSize: 12),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
