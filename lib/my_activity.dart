import 'package:flutter/material.dart';

class MyActivity extends StatelessWidget {
  const MyActivity({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Activity(),
    );
  }
}

class Activity extends StatefulWidget {
  const Activity({Key? key}) : super(key: key);

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('My Activity')),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Text('REGISTERED MEETINGS',
            style: Theme.of(context).textTheme.bodyText2,)
          ],
        ),
      ),
    );
  }
}

