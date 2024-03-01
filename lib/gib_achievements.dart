import 'package:flutter/material.dart';

import 'home.dart';


class GibAchievements extends StatelessWidget {
  const GibAchievements({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Achievements(),
    );
  }
}

class Achievements extends StatefulWidget {
  const Achievements({Key? key}) : super(key: key);

  @override
  State<Achievements> createState() => _AchievementsState();
}

class _AchievementsState extends State<Achievements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('GiB Achievements')),
        centerTitle: true,
        leading:IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) =>  Home(userType: '', userId: '',)));
            },
            icon: const Icon(Icons.arrow_back)),
      ),
    );
  }
}

