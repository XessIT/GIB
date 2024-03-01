import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../change_mpin.dart';
import '../gib_members.dart';
import '../login.dart';
import '../profile.dart';

class NonExecutiveHome extends StatefulWidget {

  final String? userID;
  final String? userType;
  NonExecutiveHome({Key? key,
    required this.userID,
    required this.userType,

    //   this.userType,
  }) : super(key: key);

  @override
  State<NonExecutiveHome> createState() => _NonExecutiveHomeState();
}

class _NonExecutiveHomeState extends State<NonExecutiveHome> {

  //  final CalendarController _calendarController =  CalendarController();

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.green[50],
      drawer:  SafeArea(
          child: NavDrawer(
            userID:widget.userID.toString(),
            userType:widget.userType.toString(),
          )),
      appBar: AppBar(centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active_outlined))
        ],
        iconTheme:  IconThemeData(
          color: Colors.white, // Set the color for the drawer icon
        ),
        title: Text("GIB",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.green.shade900,
        child: Row(
          children: [
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: () {})),
            Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.people_alt_outlined,color: Colors.white,), onPressed: () {})),

            Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.home_outlined,color: Colors.white,), onPressed: () {})),

            Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.settings_outlined,color: Colors.white,), onPressed: () {})),
            Spacer(),
            SizedBox(width:20,height:20,child: IconButton(icon: Icon(Icons.bloodtype_outlined,color: Colors.white,), onPressed: () {})),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            child: Column(
              children: [
                SafeArea(
                  child: SizedBox(
                    width: w,
                    height: 100,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left:8.0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage("assets/pro1.jpg"),
                            radius: 35,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bhuvana',
                                style: GoogleFonts.aBeeZee(
                                  fontSize: 20,
                                  color: Colors.indigo,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('memberid!',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 10,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  //  Text('${widget.userType}',
                                  Text('Executive',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 10,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text('teamName!',
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 10,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                  Text( DateFormat()
                                  // displaying formatted date
                                      .format(DateTime.now()),
                                    style: GoogleFonts.aBeeZee(
                                      fontSize: 10,
                                      color: Colors.indigo,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),




                Container(
                  width: w,
                  // height: 900,
                  decoration:   BoxDecoration(
                      color: Colors.green.shade900,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50))
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('   Upcoming Meeting',style: Theme.of(context).textTheme.titleLarge,),
                        ),
                      ),
                      const SizedBox(height: 10,width: 20,),

                      Container(
                        //  height: 300,
                        width: w,
                        color: Colors.green.shade900,
                        child: Column(
                          children: [

                            Container(
                              width: w-30,
                              height: 120,
                              //margin: const EdgeInsets.all(220.0),
                              padding: const EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    Colors.white,
                                    Colors.blue.shade100
                                  ],
                                ),
                                border: Border.all(
                                    color: Colors.green,width: 2),
                                borderRadius: BorderRadius.circular(20.0),
                                /* image: DecorationImage(
                      image: const AssetImage("assets/home.png"),
                      colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.2), BlendMode.dstATop),
                      fit: BoxFit.cover),*/
                              ),
                              child: CarouselSlider(
                                items: [
                                  Column(
                                    children: [

                                      const SizedBox(height: 30,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          const Text('4-7-2022\n'
                                              'Erode',),
                                          const Text('Team Meeting',),
                                          IconButton(
                                              onPressed: () {
                                                showDialog(
                                                    context: context,
                                                    builder: (ctx) =>
                                                    // Dialog box for register meeting and add guest
                                                    AlertDialog(
                                                      backgroundColor: Colors.grey[800],
                                                      title: const Text(
                                                          'Meeting',
                                                          style: TextStyle(
                                                              color: Colors.white)),
                                                      content: const Text(
                                                          "Meeting Registered Successfully",
                                                          style: TextStyle(
                                                              color: Colors.white)),
                                                      actions: [
                                                        TextButton(
                                                            onPressed: () {
                                                              showDialog(
                                                                  context: context,
                                                                  builder: (ctx) =>
                                                                  // Dialog box for register meeting and add guest
                                                                  AlertDialog(
                                                                    backgroundColor: Colors.grey[800],
                                                                    title: const Text('Add',
                                                                        style: TextStyle(
                                                                            color: Colors.white)),
                                                                    content: const Text("Do you wish to add Guest?",
                                                                        style: TextStyle(
                                                                            color: Colors.white)),
                                                                    actions: [
                                                                      TextButton(
                                                                          onPressed: () {
                                                                            //        Navigator.push(
                                                                            //         context,
                                                                            //        MaterialPageRoute(builder: (context) =>
                                                                            //    const VisitorsSlip()),
                                                                            //      );
                                                                          },
                                                                          child: const Text('Yes')),
                                                                      /*   TextButton(
                                                            onPressed: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(builder: (context) =>
                                                                const NonExeHomepage()),
                                                              );
                                                            },
                                                            child: const Text('No'))
*/                                                      ],
                                                                  )
                                                              );
                                                            },
                                                            child: const Text('OK')),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.of(ctx).pop();
                                                            },
                                                            child: const Text('Cancel'))
                                                      ],
                                                    )
                                                );
                                              },
                                              icon: const Icon(
                                                Icons.person_add_alt_1_rounded,
                                                color: Colors.green,))
                                        ],
                                      )
                                    ],
                                  ),

                                  Column(
                                    children: [

                                      const SizedBox(height: 30,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            'Date: 4-7-2022\n'
                                                'Place: Erode',),
                                          Text('Network Meeting',),
                                          Icon(
                                            Icons.person_add_alt_1_rounded,
                                            color: Colors.green,)
                                        ],
                                      )
                                    ],
                                  ),

                                  Column(
                                    children: [

                                      const SizedBox(height: 30,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text('Date: 4-7-2022\n'
                                              'Place: Erode',),
                                          Text('Training Program',),
                                          Icon(Icons.person_add_alt_1_rounded,
                                            color: Colors.green,)
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                                options: CarouselOptions(
                                  height: 120.0,
                                  enlargeCenterPage: true,
                                  autoPlay: true,
                                  aspectRatio: 16 / 9,
                                  autoPlayCurve: Curves.fastOutSlowIn,
                                  enableInfiniteScroll: true,
                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                  viewportFraction: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text('Offers',style: Theme.of(context).textTheme.titleLarge,),
                        ),
                      ),
                      Container(
                        width: 380,
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Colors.white, Colors.white,
                            ],
                          ),
                          border: Border.all(
                              color: Colors.white,width: 2),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child:
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 210,
                                  width: 170,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.black,
                                      ),),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: (){},
                                            icon:  const Icon(
                                              Icons.call_outlined,
                                              color: Colors.green,)),),
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Colors.cyan,
                                        backgroundImage: const
                                        AssetImage('assets/car.jpg'),
                                        child: Stack(
                                          children: const [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: CircleAvatar(
                                                  radius: 18.5,
                                                  backgroundColor: Colors.green,
                                                  child: Text('10%',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      const Text('A1 Car Accessories',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),),
                                      const SizedBox(height: 15,),
                                      const Text('product -Ceramic Coating',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),),
                                      const SizedBox(width: 1,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Validity -',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),),
                                          Text(DateFormat
                                            ('dd/MM/yyyy').
                                          format(DateTime.now(),),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //       VerticalDivider(width: 5,thickness: 1,color: Colors.black,),
                                Container(
                                  height: 210,
                                  width: 170,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: (){},
                                            icon:  const Icon(
                                              Icons.call_outlined,
                                              color: Colors.green,)),),
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Colors.cyan,
                                        backgroundImage: const AssetImage('assets/ro.jpg'),
                                        child: Stack(
                                          children: const [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.green,
                                                  child: Text('15%',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      const Text('Jm Technology',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold), ),
                                      const SizedBox(height: 15,),
                                      const Text('Service -Ro System',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),),

                                      const SizedBox(width: 1,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Validity -',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),),
                                          Text(DateFormat
                                            ('dd/MM/yyyy').
                                          format(DateTime.now(),),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const Divider(color: Colors.black,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  height: 210,
                                  width: 170,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      right: BorderSide(
                                        color: Colors.black,
                                      ),),
                                  ),
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: (){},
                                            icon:  const Icon(
                                              Icons.call_outlined,
                                              color: Colors.green,)),),
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Colors.cyan,
                                        backgroundImage: const
                                        AssetImage('assets/car.jpg'),
                                        child: Stack(
                                          children: const [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.green,
                                                  child: Text('10%',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      const Text('A1 Car Accessories',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),),
                                      const SizedBox(height: 15,),
                                      const Text('product -Ceramic Coating',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),),
                                      const SizedBox(width: 1,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Validity -',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),),
                                          Text(
                                            DateFormat('dd/MM/yyyy').
                                            format(DateTime.now(),),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                //       VerticalDivider(width: 5,thickness: 1,color: Colors.black,),
                                Container(
                                  height: 210,
                                  width: 170,
                                  child: Column(
                                    children: [
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            onPressed: (){},
                                            icon:  const Icon(Icons.call_outlined,
                                              color: Colors.green,)),),
                                      CircleAvatar(
                                        radius: 45,
                                        backgroundColor: Colors.cyan,
                                        backgroundImage: const AssetImage('assets/ro.jpg'),
                                        child: Stack(
                                          children: const [
                                            Align(
                                              alignment: Alignment.bottomLeft,
                                              child: CircleAvatar(
                                                  radius: 20,
                                                  backgroundColor: Colors.green,
                                                  child: Text('15%',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15,),
                                      const Text('Jm Technology',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold), ),
                                      const SizedBox(height: 15,),
                                      const Text('Service -Ro System',
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold),),

                                      const SizedBox(width: 1,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Text('Validity -',
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),),
                                          Text(
                                            DateFormat('dd/MM/yyyy').
                                            format(DateTime.now(),),
                                            style: const TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 100,),



                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyBlinkingButton extends StatefulWidget {
  const MyBlinkingButton({Key? key}) : super(key: key);

  @override
  _MyBlinkingButtonState createState() => _MyBlinkingButtonState();
}

class _MyBlinkingButtonState extends State<MyBlinkingButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: const Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/profile.jpg'),
          radius: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class MyBlinkingButton1 extends StatefulWidget {
  const MyBlinkingButton1({Key? key}) : super(key: key);

  @override
  _MyBlinkingButton1State createState() => _MyBlinkingButton1State();
}

class _MyBlinkingButton1State extends State<MyBlinkingButton1>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: const Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/pro1.jpg'),
          radius: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class MyBlinkingButton2 extends StatefulWidget {
  const MyBlinkingButton2({Key? key}) : super(key: key);

  @override
  _MyBlinkingButton2State createState() => _MyBlinkingButton2State();
}

class _MyBlinkingButton2State extends State<MyBlinkingButton2>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationController,
      child: const Center(
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/pro2.jpg'),
          radius: 30,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

class NavDrawer extends StatefulWidget {
  String userType;
  final String userID;
  NavDrawer({Key? key,
    required this.userType,
    required this.userID
  }) : super(key: key);

  @override
  State<NavDrawer> createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
          children: [
            ListTile(
              tileColor: Colors.green[800],
              leading: IconButton(
                icon: const Icon(Icons.house,color: Colors.white,size: 30.0,),
                onPressed: (){
                  Navigator.of(context).pop();
                }, ),
              title: const Text('Home',
                style: TextStyle(fontSize: 20.0,color: Colors.white),),
              onTap: () => {
                /* Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>  const Profile()),
                )*/
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.snowshoeing,color: Colors.white,),
                    onPressed: () {
                      //   Navigator.push(
                      //    context,
                      //    MaterialPageRoute(builder: (context) =>  const MyActivity()),
                      //   );
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.notifications,color: Colors.white,),
                    onPressed: () {
                      //Navigator.push(
                      //  context,
                      //   MaterialPageRoute(builder: (context) =>  const NotificationPage()),
                      // );
                    },
                  ),
                ],
              ),

            ),
            ListTile(
              leading: const Icon(Icons.account_circle_sharp,color: Colors.green,),
              title: Text('Profile',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   Profile(

                    userType:  widget.userType,

                    userID:widget.userID,

                  )),
                ),
                // Navigator.pop(context),
              },
            ),
            /* ListTile(
              leading: const Icon(Icons.oil_barrel,color: Colors.green,),
              title: Text('Business',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //     Navigator.push(
                //     context,
                //    MaterialPageRoute(builder: (context) =>  const Business()),
                //   )
              },
            ),
            const Divider(color: Colors.grey,),
            ListTile(
              leading: const Icon(Icons.account_tree,color: Colors.green,),
              title: Text('Meeting',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //     Navigator.push(
                //   context,
                //    MaterialPageRoute(builder: (context) =>  const MeetingUpcoming()),
                //     )
              },
            ),*/
            ListTile(
              leading: const Icon(Icons.oil_barrel,color: Colors.green,),
              title: Text('Attendance',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //   Navigator.push(
                //   context,
                // MaterialPageRoute(builder: (context) =>  const Attendance()),
                //)
              },
            ),
            ListTile(
              leading: const Icon(Icons.qr_code,color: Colors.green,),
              title: Text('Attendance Scanner',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //      Navigator.push(
                //       context,
                //  MaterialPageRoute(builder: (context) =>  const AttendanceScanner()),
                // )
              },
            ),
            const Divider(color: Colors.grey,),
            /* ListTile(
              leading: const Icon(Icons.photo,color: Colors.green,),
              title: Text('My Gallery',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //       Navigator.push(
                //    context,
                //    MaterialPageRoute(builder: (context) =>  const MyGallery()),
                //    )
              },
            ),*/
            ListTile(
              leading: const Icon(Icons.photo,color: Colors.green,),
              title: Text('GiB Gallery',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //    Navigator.push(
                //       context,
                //       MaterialPageRoute(builder: (context) =>  const GibGallery()),
                //     )
              },
            ),
            ListTile(
              leading: const Icon(Icons.emoji_events,color: Colors.green,),
              title: Text('GiB Achievements',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //    Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) =>  const GibAchievements()),
                //   )
              },
            ),
            const Divider(color: Colors.grey,),
            ListTile(
              leading: const Icon(Icons.supervisor_account,color: Colors.green,),
              title: Text('GiB Members',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(builder: (context) =>  GibMembers(userId: widget.userID, userType: widget.userType)))
              },
            ),
            /* ListTile(
              leading: const Icon(Icons.person_add,color: Colors.green,),
              title: Text('Add Member',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //     Navigator.push(
                //    context,
                //    MaterialPageRoute(builder: (context) =>  const AddMember()),
                //    )
              },
            ),*/
            ListTile(
              leading: const Icon(Icons.local_offer,color: Colors.green,),
              title: Text('Offers',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //     Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) =>  const OffersPage()),
                //    )
              },
            ),
            const Divider(color: Colors.grey,),
            ListTile(
              leading: const Icon(Icons.add_circle,color: Colors.red,),
              title: Text('GiB Doctors',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //     Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) =>  const GibDoctors()),
                //   )
              },
            ),
            ListTile(
              leading: const Icon(Icons.bloodtype,color: Colors.red,),
              title: Text('Blood Group',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //       Navigator.push(
                //     context,
                //     MaterialPageRoute(builder: (context) =>  const BloodGroup()),
                //   )
              },
            ),
            const Divider(color: Colors.grey,),
            ListTile(
              leading: const Icon(Icons.info,color: Colors.green,),
              title: Text('About GiB',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                //          Navigator.push(
                //       context,
                //     MaterialPageRoute(builder: (context) =>  const AboutGib()),
                //    )
              },
            ),
            ListTile(
              leading: const Icon(Icons.fingerprint,color: Colors.green,),
              title: Text('Change M-Pin',
                  style: Theme.of(context).textTheme.bodyMedium),
              onTap: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>   ChangeMPin(userID:widget.userID,userType:widget.userType)),
                )
              },
            ),
            ListTile(
              leading: IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  // Clear the authentication status when logging out
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  await prefs.setBool('isLoggedIn', false);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );
                },
              ),
            ),
          ],
        )
    );
  }
}


class BlinkWidget extends StatefulWidget {
  final List<Widget> children;
  final int interval;

  const BlinkWidget({required this.children, this.interval = 500, required Key key}) : super(key: key);

  @override
  _BlinkWidgetState createState() => _BlinkWidgetState();
}

class _BlinkWidgetState extends State<BlinkWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _currentWidget = 0;

  @override
  initState() {
    super.initState();

    _controller = AnimationController(
        duration: Duration(milliseconds: widget.interval),
        vsync: this
    );

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        setState(() {
          if(++_currentWidget == widget.children.length) {
            _currentWidget = 0;
          }
        });

        _controller.forward(from: 0.0);
      }
    });

    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: widget.children[_currentWidget],
    );
  }
}




