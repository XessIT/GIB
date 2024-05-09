import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My Flutter App'),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            Positioned(
              top: kToolbarHeight / 2, // Half of app bar height
              left: 0,
              right: 0,
              child: Container(
                height: 200,
                margin: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    'Card Content',
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
