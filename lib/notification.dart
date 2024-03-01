import 'package:flutter/material.dart';

import 'meeting.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: MyNotification(),
    );
  }
}

class MyNotification extends StatefulWidget {
  const MyNotification({Key? key}) : super(key: key);

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Notifications')),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 20,),
            InkWell(
              onTap: (){
                 Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const MeetingUpcoming()),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.green,width: 2),
                    borderRadius: BorderRadius.circular(20.0)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Click to See Meeting Notification',
                    style: Theme.of(context).textTheme.bodyText1,),
                    //Badge(
                     // badgeContent: const Text('12'), //commend date 30.01.2023
                   // )
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

